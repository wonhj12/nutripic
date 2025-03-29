import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;

Future<OAuthCredential> googleCredential() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    debugPrint('Error in googleCredential');
    throw Error();
  }

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // OAuth credential 생성
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return credential;
}

Future<OAuthCredential> appleCredential() async {
  final AuthorizationCredentialAppleID appleCredential =
      await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );

  // OAuth credential 생성
  final OAuthCredential credential = OAuthProvider('apple.com').credential(
    accessToken: appleCredential.authorizationCode,
    idToken: appleCredential.identityToken,
  );

  return credential;
}

Future<OAuthCredential> kakaoCredential() async {
  // 카카오톡이 설치되어있으면 카카오톡으로 로그인 진행
  // 카카오톡이 없으면 카카오 계정으로 로그인 진행
  final kakao.UserApi _kakaoApi = kakao.UserApi.instance;
  kakao.OAuthToken token;

  if (await kakao.isKakaoTalkInstalled()) {
    token = await _kakaoApi.loginWithKakaoTalk();
  } else {
    token = await _kakaoApi.loginWithKakaoAccount();
  }

  final OAuthCredential credential = OAuthProvider('oidc.kakao')
      .credential(idToken: token.idToken, accessToken: token.accessToken);

  return credential;
}
