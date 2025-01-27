import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:nutripic/models/user_model.dart';
import 'package:nutripic/utils/api.dart';
import 'package:nutripic/utils/enums/login_type.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;
  LoginViewModel({required this.userModel, required this.context});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final kakao.UserApi _kakaoApi = kakao.UserApi.instance;

  bool isLoading = false;

  // 상단부터 로고까지 space 길이
  double topPadding() {
    return 220 - MediaQuery.of(context).padding.top;
  }

  /// 로그인 선택 시 로그인 후 서버 인증 받는 함수
  void login(LoginType loginType) async {
    isLoading = true;
    notifyListeners();

    // 로그인 진행
    User? user;
    switch (loginType) {
      // 카카오
      case LoginType.kakao:
        user = await _kakaoLogin();
        break;
      // 구글
      case LoginType.google:
        user = await _googleLogin();
        break;
      // 애플
      case LoginType.apple:
        // user = await _appleLogin();
        break;
      default:
        break;
    }

    isLoading = false;
    notifyListeners();

    // Firebase 로그인 성공시 UserModel에 사용자 데이터 저장 후 홈으로 이동
    if (user != null) {
      // User Model에 사용자 정보 저장
      userModel.fromFirebaseUser(user);

      if (context.mounted) context.go('/refrigerator');
    }
  }

  /// 카카오 로그인
  Future<User?> _kakaoLogin() async {
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
      final kakaoUser = await _kakaoApi.me();

      // 카카오 userId 넘겨주면 firebase custom token 생성
      final token = await API.postKakaoCustomToken(kakaoUser.id.toString());

      // Firebase 인증
      final userCredential = await _firebaseAuth.signInWithCustomToken(token);
      final user = userCredential.user;

      // 첫 카카오 로그인이면 기본 정보 등록
      if (userCredential.additionalUserInfo != null &&
          userCredential.additionalUserInfo!.isNewUser) {
        await user?.updateDisplayName(kakaoUser.properties?['nickname']);
        await user?.updatePhotoURL(kakaoUser.properties?['profile_image']);
      }

      return _firebaseAuth.currentUser;
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

      // 새 사용자면 db에 uid 등록
      if (userCredential.additionalUserInfo!.isNewUser) {
        await API.postUser(user!.uid);
      }

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

      // 새 사용자면 db에 uid 등록
      if (userCredential.additionalUserInfo!.isNewUser) {
        await API.postUser(user!.uid);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException in _appleLogin: ${e.code}');
      return null;
    } catch (e) {
      debugPrint('Error in _appleLogin: $e');
      return null;
    }
  }

  /// 이메일 로그인 페이지로 이동
  void emailLogin() {
    context.go('/login/email');
  }

  /// 회원가입 페이지로 이동
  void signup() {
    context.go('/login/signup');
  }
}
