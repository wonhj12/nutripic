import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:nutripic/models/user_model.dart';
import 'package:nutripic/utils/api.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;
  LoginViewModel({required this.userModel, required this.context});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final kakao.UserApi _kakaoApi = kakao.UserApi.instance;

  String email = '';
  String password = '';

  /// 로그인 선택 시 로그인 후 서버 인증 받는 함수
  ///
  /// `int loginType` : 0 - 이메일, 1 - 카카오, 2 - 구글, 3 - 애플
  void login(int loginType) async {
    User? user;
    switch (loginType) {
      // 이메일
      case 0:
        user = await _emailLogin();
      // 카카오
      case 1:
        await _kakaoLogin();
        break;
      // 구글
      case 2:
        user = await _googleLogin();
        break;
      // 애플
      case 3:
        // user = await _appleLogin();
        break;
      default:
        break;
    }

    // Firebase 로그인 성공시 UserModel에 사용자 데이터 저장 후 홈으로 이동
    if (user != null) {
      // User Model에 사용자 정보 저장
      userModel.fromFirebaseUser(user);

      if (context.mounted) context.go('/refrigerator');
    }
  }

  /// 이메일 로그인
  Future<User?> _emailLogin() async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      // https://stackoverflow.com/questions/67617502/what-are-the-error-codes-for-flutter-firebase-auth-exception
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
      debugPrint('FirebaseAuthException in _emailLogin: ${e.code}');
      return null;
    } catch (e) {
      debugPrint('Error in _emailLogin: $e');
      return null;
    }
  }

  /// 카카오 로그인
  Future<kakao.User?> _kakaoLogin() async {
    // 카카오 키 해시 확인을 위한 로그 (필요시 주석 해제 후 사용)
    // debugPrint(await kakao.KakaoSdk.origin);

    try {
      // 카카오톡이 설치되어있으면 카카오톡으로 로그인 진행
      // 카카오톡이 없으면 카카오 계정으로 로그인 진행
      if (await kakao.isKakaoTalkInstalled()) {
        await _kakaoApi.loginWithKakaoTalk();
      } else {
        await _kakaoApi.loginWithKakaoAccount();
      }
      final user = await _kakaoApi.me();
      API.postKakaoCustomToken(user.id.toString());

      return user;
    } catch (e) {
      debugPrint('Error in _kakaoLogin: $e');
      return null;
    }
  }

  /// 구글 로그인
  Future<User?> _googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // OAuth credential 생성
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase 인증
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
      debugPrint('FirebaseAuthException in _googleLogin: ${e.code}');
      return null;
    } catch (e) {
      debugPrint('Error in _googleLogin: $e');
      return null;
    }
  }

  /// 애플 로그인
  /// 애플 개발자 계정 등록 후 사용 가능
  Future<User?> _appleLogin() async {
    try {
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

      // Firebase 인증
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException in _appleLogin: ${e.code}');
      return null;
    } catch (e) {
      debugPrint('Error in _appleLogin: $e');
      return null;
    }
  }

  /// 회원가입 페이지로 이동
  void signup() {
    context.go('/login/signup');
  }
}
