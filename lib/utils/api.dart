import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class API {
  static String baseUrl = dotenv.env['API_URL']!;

  /* BASE API (GET, POST, PATCH, DELETE) */

  /// ### API GET
  /// 데이터를 받아올 때 사용
  ///
  /// 요청 성공시 `response.body`를 반환.
  /// </br> `response is Map<String, dynamic>` 확인 후 데이터 접근 할 것.
  ///
  /// 요청 실패시 `response`를 반환.
  /// </br>`statusCode`로 에러 확인 후 메시지 출력.
  static Future<dynamic> _getApi(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('GET 요청: $endPoint');

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        debugPrint('GET 요청 성공');
        return jsonDecode(response.body);
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
  /// `response.statusCode == 200` 확인 후 요청 성공 로직 진행.
  static Future<dynamic> _postApi(String endPoint, String jsonData) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    debugPrint('POST 요청: $endPoint');

    try {
      final response =
          await http.post(Uri.parse(apiUrl), headers: headers, body: jsonData);
      if (response.statusCode == 200) {
        debugPrint('POST 요청 성공');
      } else {
        debugPrint('POST 요청 실패: (${response.statusCode})${response.body}');
      }

      return response;
    } catch (e) {
      debugPrint('POST 요청 중 예외 발생: $e');
      return;
    }
  }

  /// ### API PATCH
  /// 데이터 일부 수정시 사용
  ///
  /// `response.statusCode == 200` 확인 후 요청 성공 로직 진행.
  static Future<dynamic> _patchApi(String endPoint, String? jsonData) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    debugPrint('PATCH 요청: $endPoint');

    try {
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
  /// `response.statusCode == 200` 확인 후 요청 성공 로직 진행.
  static Future<dynamic> _deleteApi(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('DELETE 요청: $endPoint');

    try {
      final response = await http.delete(Uri.parse(apiUrl));

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
