import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/bottom_navigator_bar.dart';
import 'package:nutripic/models/user_model.dart';
import 'package:nutripic/view_models/home_view_model.dart';
import 'package:nutripic/view_models/login_view_model.dart';
import 'package:nutripic/views/camera_view.dart';
import 'package:nutripic/views/detail_view.dart';
import 'package:nutripic/views/diary_view.dart';
import 'package:nutripic/views/home_view.dart';
import 'package:nutripic/views/login_view.dart';
import 'package:nutripic/views/recipe_view.dart';
import 'package:nutripic/views/refrigerator_view.dart';
import 'package:nutripic/views/user_info_view.dart';
import 'package:provider/provider.dart';

// for global key
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

class AppRouter {
  final UserModel userModel;
  AppRouter({required this.userModel});

  static GoRouter getRouter(UserModel userModel) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/login',
      redirect: (context, state) {
        // 사용자 데이터가 있으면 firebase 로그인이 완료된 상태
        // 사용자 데이터가 없으면 로그인 화면으로 이동, 있으면 홈 화면으로 이동
        if (userModel.uid == null) {
          return '/login';
        } else if (state.fullPath == '/login') {
          return '/refrigerator';
        } else {
          return null;
        }
      },
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return BottomNavBar(navigationShell: navigationShell);
          },
          branches: [
            // 냉장고
            StatefulShellBranch(
              navigatorKey: _sectionANavigatorKey,
              routes: [
                GoRoute(
                  path: '/refrigerator',
                  builder: (BuildContext context, GoRouterState state) =>
                      const RefrigeratorView(),
                )
              ],
            ),
            // 식단일지
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/diary',
                  builder: (BuildContext context, GoRouterState state) =>
                      const DiaryView(),
                )
              ],
            ),
            // 카메라
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/camera',
                  builder: (BuildContext context, GoRouterState state) =>
                      const CameraView(),
                )
              ],
            ),
            // 레시피
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/recipe',
                  builder: (BuildContext context, GoRouterState state) =>
                      const RecipeView(),
                )
              ],
            ),
            // 사용자 정보
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/user',
                  builder: (BuildContext context, GoRouterState state) =>
                      const UserInfoView(),
                )
              ],
            ),
          ],
        ),

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
