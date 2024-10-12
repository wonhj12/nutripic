import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class API {
  static String baseUrl = dotenv.env['SERVER_API']!;
  static final _firebaseAuth = FirebaseAuth.instance;

  /// Firebase 인증을 위한 사용자 id token을 반환하는 함수
  ///
  /// 토큰이 만료되었다면 firebase에서 새로 발급한 토큰 반환, 만료되지 않았다면 현재 토큰을 반환
  /// </br> Firebase 로그인이 되어있지 않은 상태에서 토큰을 요청하면 `user-not-found` 오류 반환
  static Future<String?> _getToken() async {
    String? token;

    if (_firebaseAuth.currentUser != null) {
      token = await _firebaseAuth.currentUser!.getIdToken();
    } else {
      throw ErrorDescription('user-not-found');
    }

    return token;
  }

  /// 카카오 로그인시 백엔드 서버에서 firebase 인증을 위한 custom ID token을 받아오는 함수
  static Future<String> postKakaoCustomToken(String uid) async {
    String token = '';

    try {
      await _postApi(
        'auth/kakao',
        jsonEncode({'uid': uid}),
        tokenRequired: false,
      );
    } catch (e) {
      debugPrint('Error in postKakaoCustomToken: $e');
      throw Error();
    }

    return token;
  }

  /* BASE API (GET, POST, PATCH, DELETE) */

  /// ### API GET
  /// 데이터를 받아올 때 사용
  ///
  /// `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  ///
  /// 요청 성공시 `response.body`를 반환.
  /// </br> `response is Map<String, dynamic>` 확인 후 데이터 접근 할 것.
  ///
  /// 요청 실패시 `response`를 반환.
  /// </br>`statusCode`로 에러 확인 후 메시지 출력.
  static Future<dynamic> _getApi(String endPoint,
      {bool tokenRequired = true}) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {};
    debugPrint('GET 요청: $endPoint');

    try {
      // 헤더에 토큰 추가
      if (tokenRequired) {
        String? token = await _getToken();
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        debugPrint('GET 요청 성공');
      } else {
        debugPrint('GET 요청 실패: (${response.statusCode})${response.body}');
      }

      return response;
    } catch (e) {
      debugPrint('GET 요청 중 예외 발생: $e');
      return e;
    }
  }

  /// ### API POST
  /// 데이터 생성시 사용
  ///
  /// `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  ///
  /// `response.statusCode == 200` 확인 후 요청 성공 로직 진행.
  static Future<dynamic> _postApi(String endPoint, String jsonData,
      {bool tokenRequired = true}) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    debugPrint('POST 요청: $endPoint');

    try {
      // 헤더에 토큰 추가
      if (tokenRequired) {
        String? token = await _getToken();
        headers['Authorization'] = 'Bearer $token';
      }

      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
      if (response.statusCode == 201) {
        debugPrint('POST 요청 성공');
      } else {
        debugPrint('POST 요청 실패: (${response.statusCode})${response.body}');
      }

      // final dioResponse = await dio.post(endPoint, data: jsonData);

      return response;
    } catch (e) {
      debugPrint('POST 요청 중 예외 발생: $e');
      return;
    }
  }

  /// ### API PATCH
  /// 데이터 일부 수정시 사용
  ///
  /// `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  ///
  /// `response.statusCode == 200` 확인 후 요청 성공 로직 진행.
  static Future<dynamic> _patchApi(String endPoint, String? jsonData,
      {bool tokenRequired = true}) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    debugPrint('PATCH 요청: $endPoint');

    try {
      // 헤더에 토큰 추가
      if (tokenRequired) {
        String? token = await _getToken();
        headers['Authorization'] = 'Bearer $token';
      }

      final response =
          await http.patch(Uri.parse(apiUrl), headers: headers, body: jsonData);
      if (response.statusCode == 200) {
        debugPrint('PATCH 요청 성공');
      } else {
        debugPrint('PATCH 요청 실패: (${response.statusCode})${response.body}');
      }

      return response;
    } catch (e) {
      debugPrint('PATCH 요청 중 예외 발생: $e');
      return;
    }
  }

  /// ### API DELETE
  /// 데이터 삭제시 사용
  ///
  /// `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  ///
  /// `response.statusCode == 200` 확인 후 요청 성공 로직 진행.
  static Future<dynamic> _deleteApi(String endPoint,
      {bool tokenRequired = true}) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {};
    debugPrint('DELETE 요청: $endPoint');

    try {
      // 헤더에 토큰 추가
      if (tokenRequired) {
        String? token = await _getToken();
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.delete(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        debugPrint('DELETE 요청 성공');
      } else {
        debugPrint('DELETE 요청 실패: (${response.statusCode})${response.body}');
      }

      return response;
    } catch (e) {
      debugPrint('DELETE 요청 중 예외 발생: $e');
      return;
    }
  }
}
