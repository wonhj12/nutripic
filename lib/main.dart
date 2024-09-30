import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:nutripic/models/user_model.dart';
import 'package:nutripic/utils/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']);

  // 가능하다면 자동 로그인 진행
  await autoLogin();

  runApp(const MainApp());
}

/// Firebase 로그인 정보가 있는지 확인 후 있다면 사용자 정보를 모델에 저장하는 함수
Future<void> autoLogin() async {
  // Firebase 로그인이 된 상태라면 서버에서 사용자 정보 요청
  if (FirebaseAuth.instance.currentUser != null) {
    userModel.uid = FirebaseAuth.instance.currentUser!.uid;
    userModel.name = FirebaseAuth.instance.currentUser!.displayName;
  }
}

// 모델
UserModel userModel = UserModel();

// 라우터
final _router = AppRouter.getRouter(userModel);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
