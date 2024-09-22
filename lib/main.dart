import 'package:flutter/material.dart';
import 'package:nutripic/utils/app_router.dart';

void main() {
  runApp(const MainApp());
}

final _router = AppRouter.getRouter();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
