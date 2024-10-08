import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;

  /// ### Padding, margin 등 공통 설정 값이 적용된 Scaffold
  /// 좌우 padding: 20px
  const CustomScaffold({
    super.key,
    this.appBar,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: body,
      ),
    );
  }
}
