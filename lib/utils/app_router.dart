import 'package:go_router/go_router.dart';
import 'package:nutripic/models/user_model.dart';
import 'package:nutripic/view_models/home_view_model.dart';
import 'package:nutripic/view_models/login_view_model.dart';
import 'package:nutripic/views/home_view.dart';
import 'package:nutripic/views/login_view.dart';
import 'package:provider/provider.dart';

class AppRouter {
  final UserModel userModel;
  AppRouter({required this.userModel});

  static GoRouter getRouter(UserModel userModel) {
    return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        // 사용자 데이터가 있으면 firebase 로그인이 완료된 상태
        // 사용자 데이터가 없으면 로그인 화면으로 이동, 있으면 홈 화면으로 이동
        if (userModel.uid == null) {
          return '/login';
        } else if (state.fullPath == '/login') {
          return '/home';
        } else {
          return null;
        }
      },
      routes: [
        // 로그인
        GoRoute(
          path: '/login',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => LoginViewModel(
              userModel: userModel,
              context: context,
            ),
            child: const LoginView(),
          ),
        ),

        // 홈
        GoRoute(
          path: '/home',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => HomeViewModel(
              userModel: userModel,
              context: context,
            ),
            child: const HomeView(),
          ),
        )
      ],
    );
  }
}
