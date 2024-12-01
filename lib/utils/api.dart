import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nutripic/utils/custom_interceptor.dart';

class API {
  static final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['SERVER_API']!,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

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
      // debugPrint('Error in postKakaoCustomToken: $e');
      throw Error();
    }

    return token;
  }

  /* Storage */

  /// 냉장고에 저장돼있는 식재료를 받아오는 함수
  /// Freezer, Fridge, Room에 있는 foods를 반환
  static Future<List<dynamic>> getFoods() async {
    try {
      final response = await _getApi('/storage');
      if (response != null) return response.data;
    } catch (e) {
      // debugPrint('Error in getFoods: $e');
      throw Error();
    }

    return [];
  }

  static Future<dynamic> deleteFood(int foodId) async {
    try {
      final response = await _deleteApi(
        '/storage/delete',
        jsonData: jsonEncode({'id': foodId}),
      );
      return response;
    } catch (e) {
      // debugPrint('Error in deleteFood: $e');
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
    Map<String, dynamic>? queryParameters,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.get(endPoint, queryParameters: queryParameters);
  }

  /// ### API POST
  /// 데이터 생성시 POST 요청을 보내는 함수
  ///
  /// `jsonData`가 있으면 request body를 포함해서 요청
  /// <br /> `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  static Future<dynamic> _postApi(
    String endPoint, {
    String? jsonData,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
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
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.delete(endPoint, data: jsonData);
  }
}
