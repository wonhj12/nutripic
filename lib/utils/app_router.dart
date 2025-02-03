import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/common/bottom_navbar.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:nutripic/models/refrigerator_model.dart';
import 'package:nutripic/models/user_model.dart';
import 'package:nutripic/view_models/camera/camera_add_view_model.dart';
import 'package:nutripic/view_models/camera/camera_view_model.dart';
import 'package:nutripic/view_models/diary/diary_post_view_model.dart';
import 'package:nutripic/view_models/diary/diary_record_view_model.dart';
import 'package:nutripic/view_models/diary/diary_view_model.dart';
import 'package:nutripic/view_models/login/email_view_model.dart';
import 'package:nutripic/view_models/login/login_view_model.dart';
import 'package:nutripic/view_models/login/signup_view_model.dart';
import 'package:nutripic/view_models/recipe/recipe_detail_view_model.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:nutripic/view_models/onboarding_view_model.dart';
import 'package:nutripic/view_models/refrigerator/refrigerator_view_model.dart';
import 'package:nutripic/view_models/user_info/user_edit_view_model.dart';
import 'package:nutripic/view_models/user_info/user_info_view_model.dart';
import 'package:nutripic/views/camera/camera_add_view.dart';
import 'package:nutripic/views/diary/diary_record_view.dart';
import 'package:nutripic/views/diary/diary_view.dart';
import 'package:nutripic/views/login/email_view.dart';
import 'package:nutripic/views/login/signup_view.dart';
import 'package:nutripic/views/camera/camera_view.dart';
import 'package:nutripic/views/diary/diary_post_view.dart';
import 'package:nutripic/views/login/login_view.dart';
import 'package:nutripic/views/recipe/recipe_detail_view.dart';
import 'package:nutripic/views/recipe/recipe_view.dart';
import 'package:nutripic/views/onboarding_view.dart';
import 'package:nutripic/views/refrigerator/refrigerator_view.dart';
import 'package:nutripic/views/user_info/user_edit_view.dart';
import 'package:nutripic/views/user_info/user_info_view.dart';
import 'package:provider/provider.dart';

class AppRouter {
  final UserModel userModel;
  final RefrigeratorModel refrigeratorModel;
  final DiaryModel diaryModel;
  final RecipeModel recipeModel;

  AppRouter({
    required this.diaryModel,
    required this.refrigeratorModel,
    required this.userModel,
    required this.recipeModel,
  });

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static GoRouter getRouter(
    UserModel userModel,
    RefrigeratorModel refrigeratorModel,
    DiaryModel diaryModel,
    RecipeModel recipeModel,
  ) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/login',
      redirect: (context, state) {
        // 사용자 데이터가 있으면 firebase 로그인이 완료된 상태
        // 사용자 데이터가 없으면 로그인 화면으로 이동, 있으면 홈 화면으로 이동
        if (userModel.uid == null) {
          // 회원가입, 이메일 로그인 페이지로 이동만 허용
          if (state.fullPath == '/login/signup' ||
              state.fullPath == '/login/email') {
            return null;
          }

          // 로그인이 되지 않은 상태에서 다른 페이지로 이동하려 하면 login 페이지로 리디렉팅
          return '/login';
        } else if (state.fullPath == '/login') {
          return '/refrigerator';
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
          routes: [
            // 이메일 로그인
            GoRoute(
              path: 'email',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => EmailViewModel(
                  userModel: userModel,
                  context: context,
                ),
                child: const EmailView(),
              ),
            ),

            // 회원가입
            GoRoute(
              path: 'signup',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => SignupViewModel(
                  userModel: userModel,
                  context: context,
                ),
                child: const SignupView(),
              ),
            )
          ],
        ),
        // 온보딩
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => OnboardingViewModel(
              context: context,
            ),
            child: const OnboardingView(),
          ),
        ),

        // 메인
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              BottomNavbar(navigationShell: navigationShell),
          branches: [
            // 냉장고
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/refrigerator',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => RefrigeratorViewModel(
                      refrigeratorModel: refrigeratorModel,
                      context: context,
                    ),
                    child: const RefrigeratorView(),
                  ),
                  routes: [
                    GoRoute(
                      path: 'camera',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => CameraViewModel(
                          refrigeratorModel: refrigeratorModel,
                          context: context,
                        ),
                        child: const CameraView(),
                      ),
                    ),
                    GoRoute(
                      path: 'add',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => CameraAddViewModel(
                          refrigeratorModel: refrigeratorModel,
                          context: context,
                        ),
                        child: const CameraAddView(),
                      ),
                    ),
                  ],
                )
              ],
            ),

            // 식단일지
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/diary',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => DiaryViewModel(
                      diaryModel: diaryModel,
                      context: context,
                    ),
                    child: const DiaryView(),
                  ),
                  routes: [
                    GoRoute(
                      path: 'post',
                      builder: (context, state) {
                        final selectedDay = state.extra as DateTime;
                        return ChangeNotifierProvider(
                          create: (context) => DiaryPostViewModel(
                            diaryModel: diaryModel,
                            context: context,
                            selectedDate: selectedDay,
                          ),
                          child: const DiaryPostView(),
                        );
                      },
                    ),
                    GoRoute(
                      path: 'record',
                      // builder: (context, state) {
                      //   final selectedDay = state.extra as DateTime;
                      //   return ChangeNotifierProvider(
                      //     create: (context) => DiaryRecordViewModel(
                      //       diaryModel: diaryModel,
                      //       context: context,
                      //       selectedDate: selectedDay,
                      //     ),
                      //     child: const DiaryRecordView(),
                      //   );
                      // },
                      pageBuilder: (context, state) {
                        final selectedDay = state.extra as DateTime;
                        return CustomTransitionPage<void>(
                          key: state.pageKey,
                          child: ChangeNotifierProvider(
                            create: (context) => DiaryRecordViewModel(
                              diaryModel: diaryModel,
                              context: context,
                              selectedDate: selectedDay,
                            ),
                            child: const DiaryRecordView(),
                          ),
                          transitionDuration: const Duration(milliseconds: 300),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0); // 아래에서 시작
                            const end = Offset.zero; // 원래 위치로 이동
                            const curve = Curves.easeInOut; // 부드러운 애니메이션

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

            // 카메라
            // StatefulShellBranch(
            //   routes: [
            //     GoRoute(
            //       path: '/camera',
            //       builder: (context, state) => ChangeNotifierProvider(
            //         create: (context) => CameraViewModel(
            //           refrigeratorModel: refrigeratorModel,
            //           context: context,
            //         ),
            //         child: const CameraView(),
            //       ),
            //     ),
            //   ],
            // ),

            // 레시피
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/recipe',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => RecipeViewModel(
                      recipeModel: recipeModel,
                      context: context,
                    ),
                    child: const RecipeView(),
                  ),
                  routes: [
                    GoRoute(
                      path: 'detail',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => RecipeDetailViewModel(
                          recipeModel: recipeModel,
                          context: context,
                        ),
                        child: const RecipeDetailView(),
                      ),
                    )
                  ],
                ),
              ],
            ),

            // 사용자 정보
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/user',
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => UserInfoViewModel(
                      userModel: userModel,
                      context: context,
                    ),
                    child: const UserInfoView(),
                  ),
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (context) => UserEditViewModel(
                          userModel: userModel,
                          context: context,
                        ),
                        child: const UserEditView(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
