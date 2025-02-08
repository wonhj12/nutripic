import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/custom_interceptor.dart';

class API {
  static final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['SERVER_API']!,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 10000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  /* user */
  /// 카카오 로그인시 백엔드 서버에서 firebase 인증을 위한 custom ID token을 받아오는 함수
  static Future<String> postKakaoCustomToken(String uid) async {
    String token = '';

    try {
      final response = await _postApi(
        '/auth/kakao',
        jsonData: jsonEncode({'uid': uid}),
        tokenRequired: false,
      );

      if (response != null) {
        return response.data['firebaseToken'];
      }
    } catch (e) {
      debugPrint('Error in postKakaoCustomToken: $e');
      throw Error();
    }

    return token;
  }

  // TODO : User 반환하도록 리팩토링
  /// 회원가입 후 db에 사용자 정보를 저장하는 함수
  static Future<dynamic> postUser(String uid) async {
    try {
      final response = await _postApi(
        '/user/create',
        jsonData: jsonEncode({'uid': uid}),
      );

      return response;
    } catch (e) {
      debugPrint('Error in postUser: $e');
      throw Error();
    }
  }

  /* Storage */

  /// 냉장고에 저장돼있는 식재료를 받아오는 get 요청
  /// Freezer, Fridge, Room에 있는 식재료(food)를 반환
  static Future<List<List<Food>>> getFoods() async {
    List<List<Food>> foods = [[], [], []];

    try {
      final response = await _getApi('/storage');
      if (response != null) {
        final data = response.data;
        if (data.isNotEmpty) {
          for (var storage in data) {
            String storageType = storage['storage'];
            List<dynamic> foodList = storage['foods'];

            if (foodList.isNotEmpty) {
              List<Food> parsedFoods =
                  foodList.map((food) => Food.fromJson(food)).toList();

              switch (storageType) {
                case 'fridge':
                  foods[0].addAll(parsedFoods);
                  break;
                case 'freezer':
                  foods[1].addAll(parsedFoods);
                  break;
                case 'room':
                  foods[2].addAll(parsedFoods);
                  break;
              }
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error in getFoods: $e');
      throw Error();
    }

    return foods;
  }

  /// 냉장고에 저장된 식재료를 삭제하는 delete 요청
  static Future<void> deleteFood(List<int> foodIds) async {
    try {
      await _deleteApi('/storage/delete', jsonData: jsonEncode(foodIds));
    } catch (e) {
      debugPrint('Error in deleteFood: $e');
      throw Error();
    }
  }

  /// 촬영한 식재료 사진을 서버에 전송하는 함수
  /// <br /> GPT 인식 후 인식된 식재료를 받음
  static Future<List<List<Food>>> postImageToFood(File image) async {
    try {
      final response = await _postApi(
        '/image-to-food/analyze',
        jsonData: FormData.fromMap(
          {'image': await MultipartFile.fromFile(image.path)},
        ),
      );

      if (response != null) {
        final data = response.data;
        if (data.isNotEmpty) {
          return data.map<List<Food>>((foods) {
            return (foods as List<dynamic>)
                .map<Food>((food) => Food.fromJson(food))
                .toList();
          }).toList();
        }
      }
    } catch (e) {
      debugPrint('Error in postImageToFood: $e');
      throw Error();
    }

    return [[], [], []];
  }

  /// 식재료를 DB에 등록하는 post 요청
  static Future<void> postFoods(List<List<Food>> recognizedFoods) async {
    try {
      List<Map<String, dynamic>> data = [];
      List<String> storageTypes = ['fridge', 'freezer', 'room'];

      for (int i = 0; i < recognizedFoods.length; i++) {
        for (Food food in recognizedFoods[i]) {
          Map<String, dynamic> foodMap = food.toJson();
          foodMap['storageType'] = storageTypes[i];
          data.add(foodMap);
        }
      }

      await _postApi('/storage/add', jsonData: jsonEncode(data));
    } catch (e) {
      debugPrint('Error in postFoods: $e');
      throw Error();
    }
  }

  /* Recipes */

  /// 레시피 가져오는 함수
  static Future<dynamic> getRecipes() async {
    try {
      final response = await _getApi('/recipe/recommended');

      if (response != null) {
        return response.data;
      } else {
        return ([]);
      }
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }

  static Future<dynamic> recipePreview(List<int> recipeIds) async {
    try {
      final response = await _getApi(
        '/recipe/previews',
        jsonData: jsonEncode({'recipeIds': recipeIds}),
      );

      if (response != null && response.data != null) {
        List<dynamic> data = response.data;
        List<Recipe> recipes =
            data.map((json) => Recipe.fromJson(json)).toList();

        return recipes;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }

  static Future<dynamic> getSpecificRecipes(int id) async {
    try {
      final response = await _getApi(
        '/recipe/detail/$id',
      );

      if (response != null && response.data != null) {
        return response.data;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }

  /* Diary */

  /// 특정 유저의 모든 다이어리 조회
  static Future<dynamic> getDiariesForMonth(int idx) async {
    try {
      final response = await _getApi(
        '/diary/calendar/$idx',
      );
      return response;
    } catch (e) {
      debugPrint('Error in getDiary: $e');
      throw Error();
    }
  }

  /// 특정 다이어리 조회
  static Future<dynamic> getDiariesForDay(int diaryId) async {
    try {
      final response = await _getApi(
        '/diary/$diaryId',
      );
      return response;
    } catch (e) {
      debugPrint('Error in getDiariesForDay: $e');
      throw Error();
    }
  }

  /// 다이어리 생성
  static Future<dynamic> addDiary(
      String body, DateTime date, String url) async {
    try {
      final response = await _postApi(
        '/diary/add',
        jsonData: jsonEncode({
          'body': body,
          'date': date.toIso8601String(),
          'url': url,
        }),
      );
      return response;
    } catch (e) {
      debugPrint('Error in addDiary: $e');
      throw Error();
    }
  }

  /// 특정 다이어리 삭제
  static Future<dynamic> deleteDiary(int diaryId) async {
    try {
      final response = await _deleteApi(
        '/diary/delete/$diaryId',
      );
      debugPrint(response);
      return response;
    } catch (e) {
      debugPrint('Error in deleteDiary: $e');
      throw Error();
    }
  }

  /* BASE API (GET, POST, PATCH, DELETE) */

  /// ### API GET
  /// 데이터를 받아올 때 GET 요청을 보내는 함수
  ///
  /// `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  static Future<dynamic> _getApi(
    String endPoint, {
    String? jsonData,
    Map<String, dynamic>? queryParameters,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.get(
      endPoint,
      data: jsonData,
      queryParameters: queryParameters,
    );
  }

  /// ### API POST
  /// 데이터 생성시 POST 요청을 보내는 함수
  ///
  /// `jsonData`가 있으면 request body를 포함해서 요청
  /// <br /> `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  static Future<dynamic> _postApi(
    String endPoint, {
    Object? jsonData,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.post(endPoint, data: jsonData);
  }

  /// ### API PATCH
  /// 데이터 일부 수정시 PATCH 요청을 보내는 함수
  ///
  /// `jsonData`가 있으면 request body를 포함해서 요청
  /// <br /> `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  static Future<dynamic> _patchApi(
    String endPoint, {
    String? jsonData,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.patch(endPoint, data: jsonData);
  }

  /// ### API DELETE
  /// 데이터 삭제시 DELETE 요청을 보내는 함수
  ///
  /// `jsonData`가 있으면 request body를 포함해서 요청
  /// <br /> `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  static Future<dynamic> _deleteApi(
    String endPoint, {
    String? jsonData,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.delete(endPoint, data: jsonData);
  }
}
