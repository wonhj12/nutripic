import 'package:go_router/go_router.dart';
import 'package:nutripic/view_models/login_view_model.dart';
import 'package:nutripic/views/login_view.dart';
import 'package:provider/provider.dart';

class AppRouter {
  AppRouter();

  static GoRouter getRouter() {
    return GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => ChangeNotifierProvider(
            create: (context) => LoginViewModel(context: context),
            child: const LoginView(),
          ),
        )
      ],
    );
  }
}
