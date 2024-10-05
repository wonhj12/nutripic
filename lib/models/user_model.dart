import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  /// Firebase에서 제공하는 uid
  String? uid;

  /// 사용자 이름
  String? name;

  /// 사용자 이메일
  String? email;

  /// 사용자 프로필 사진 url
  String? profileUrl;

  /// 사용자 로그인 타입
  ///
  /// 0 - email, 1 - kakao, 2 - google, 3 - apple
  int? loginType;

  /// 사용자 생성 날짜
  DateTime? createdAt;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.profileUrl,
    this.loginType,
    this.createdAt,
  });

  /// Firebase에서 받아온 사용자 데이터를 모델에 저장하는 함수
  void fromFirebaseUser(User user) {
    uid = user.uid;
    name = user.displayName;
    email = user.email;
    profileUrl = user.photoURL;
    final provider = user.providerData[0].providerId;
    switch (provider) {
      case 'password':
        loginType = 0;
        break;
      case 'kakao':
        loginType = 1;
        break;
      case 'google.com':
        loginType = 2;
        break;
      case 'apple':
        loginType = 3;
        break;
      default:
        loginType = 0;
        break;
    }
    createdAt = user.metadata.creationTime;
  }

  /// 모델 데이터를 초기화하는 함수
  void reset() {
    uid = null;
    name = null;
    email = null;
    profileUrl = null;
    loginType = null;
    createdAt = null;
  }

  // 모델 프린트 형식
  @override
  String toString() {
    return 'uid: $uid, '
        'name: $name, '
        'email: $email '
        'profileUrl: $profileUrl '
        'loginType: $loginType '
        'createdAt: $createdAt ';
  }
}
