import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/models/user_model.dart';
import 'package:nutripic/utils/app_router.dart';
import 'package:nutripic/utils/custom_theme_data.dart';

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
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // 사용자가 존재한다면 모델에 데이터 저장
    userModel.fromFirebaseUser(user);

    // 냉장고 불러오기
    await refrigeratorModel.getFoods();
  } else {
    // 사용자가 존재하지 않는다면 모델 리셋 (혹시 모를 상황 대비)
    userModel.reset();
  }
}

// 모델
UserModel userModel = UserModel();
RefrigeratorModel refrigeratorModel = RefrigeratorModel();
DiaryModel diaryModel = DiaryModel();

// 라우터
final _router = AppRouter.getRouter(userModel, refrigeratorModel, diaryModel);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: CustomThemeData.light,
      debugShowCheckedModeBanner: false,
    );
  }
}


// eyJhbGciOiJSUzI1NiIsImtpZCI6IjNmZDA3MmRmYTM4MDU2NzlmMTZmZTQxNzM4YzJhM2FkM2Y5MGIyMTQiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoi7JuQ7ZWY7KeEIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0wzeUVJMEsxR280cDB3bkZUTEpmSWtuQzJUdS16NjNJSVhxckMtdWluTTQ2c0FzVWc9czk2LWMiLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbnV0cmlwaWMtMTA1NWIiLCJhdWQiOiJudXRyaXBpYy0xMDU1YiIsImF1dGhfdGltZSI6MTczMjc3MDM1NywidXNlcl9pZCI6ImJEbk16Sk40d0JSWTViRzdhNHpxZnQ5S2Y3WDIiLCJzdWIiOiJiRG5NekpONHdCUlk1Ykc3YTR6cWZ0OUtmN1gyIiwiaWF0IjoxNzMyOTQ4NjU4LCJleHAiOjE3MzI5NTIyNTgsImVtYWlsIjoid29uaGoxMEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJnb29nbGUuY29tIjpbIjEwMzgwNzAyNDc2NTA5MzU4NDgxNSJdLCJlbWFpbCI6WyJ3b25oajEwQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.k9Z1UiyIStEtu4igtQEIJ4ttDJau1n7ePtaxFq9LBQM4Y2GNpAtXphWrfsQNYy5PoDZ52FA5Y9j97H-vTZLRLGrNX8fzw3vCkJP5LIXq8xy4Vh81MwpYUrOs96eCsEEP0IznY0BT8YpE6laU59yPHdqQSXVrvjxooyfdQvaE68yAW3Z7rFL6rtpegJEsyOw_HmKUbYSwVCVPOadh1vVfpfWZ-ECtHD9313rh0BvgFGGLDl28bY3d1wdJqw2gZIg8ywZ4OF5V-BrU3ZXw4jjkJI6H3qIovq3nR0ia7xC2fEtVP7CVZZ8HMBDPbE0X842d2ZqB4z1sedRjjLqtL5CYNw