import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  /// Firebase에서 제공하는 uid
  String? uid;

  /// 사용자 이름
  String? name;

  /// 사용자 프로필 사진 url
  String? profileUrl;

  UserModel({
    this.uid,
    this.name,
    this.profileUrl,
  });

  /// 서버에서 받아온 사용자 데이터를 모델에 저장하는 함수
  void fromJson(Map<String, dynamic> jsonData) {
    uid = jsonData['uid'];
    name = jsonData['name'];
    profileUrl = jsonData['profileUrl'];
  }

  /// 모델 데이터를 초기화하는 함수
  void reset() {
    uid = null;
    name = null;
    profileUrl = null;
  }

  // 모델 프린트 형식
  @override
  String toString() {
    return 'uid: $uid, '
        'name: $name, '
        'profileUrl: $profileUrl';
  }
}
