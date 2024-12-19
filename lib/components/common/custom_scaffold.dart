import 'package:flutter/material.dart';
import 'package:nutripic/components/common/loading_screen.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final bool? resizeToAvoidBottomInset;
  final bool isLoading;
  final double padding;
  final bool useSafeArea;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  /// ### Padding, margin 등 공통 설정 값이 적용된 Scaffold
  /// 좌우 padding: 20px
  const CustomScaffold({
    super.key,
    this.appBar,
    this.resizeToAvoidBottomInset,
    this.isLoading = false,
    this.padding = 16,
    this.useSafeArea = true,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(
          left: useSafeArea,
          top: useSafeArea,
          right: useSafeArea,
          bottom: useSafeArea,
          child: Stack(
            children: [
              // body
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: body,
              ),

              // 로딩
              if (isLoading) const Center(child: LoadingScreen())
            ],
          ),
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
