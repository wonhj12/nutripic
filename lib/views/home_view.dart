import 'package:flutter/material.dart';
import 'package:nutripic/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = context.watch<HomeViewModel>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('asdf')),
          ElevatedButton(
            onPressed: () => homeViewModel.logout(),
            child: const Text('로그아웃'),
          )
        ],
      ),
    );
  }
}
