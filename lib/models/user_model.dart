import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// 로그인 방식 (이메일, 카카오, 구글, 애플)
enum LoginType { email, kakao, google, apple }

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
  LoginType? loginType;

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
    if (user.providerData.isEmpty) {
      loginType = LoginType.kakao;
    } else {
      final provider = user.providerData[0].providerId;
      switch (provider) {
        case 'password':
          loginType = LoginType.email;
          break;
        case 'kakao':
          loginType = LoginType.kakao;
          break;
        case 'google.com':
          loginType = LoginType.google;
          break;
        case 'apple':
          loginType = LoginType.apple;
          break;
        default:
          loginType = LoginType.email;
          break;
      }
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
