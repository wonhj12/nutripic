import 'package:firebase_auth/firebase_auth.dart';
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
        User? user = FirebaseAuth.instance.currentUser;

        // Firebase 로그인이 된 상태라면 홈으로 이동, 아니면 로그인 화면으로 이동
        if (user == null) {
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
            create: (context) => LoginViewModel(context: context),
            child: const LoginView(),
          ),
        ),

        // 홈
        GoRoute(
          path: '/home',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => HomeViewModel(context: context),
            child: const HomeView(),
          ),
        )
      ],
    );
  }
}
