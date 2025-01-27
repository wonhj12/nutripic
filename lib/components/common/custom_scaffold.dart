import 'package:flutter/material.dart';
import 'package:nutripic/components/common/loading_screen.dart';

class CustomScaffold extends StatelessWidget {
  /// 앱바 위젯
  final PreferredSizeWidget? appBar;

  /// 하단 크기 자동 조절
  final bool? resizeToAvoidBottomInset;

  /// 배경 색
  final Color? backgroundColor;

  /// 로딩 중 여부
  final bool isLoading;

  /// 패딩
  final double padding;

  /// SafeArea 사용 여부
  final bool useSafeArea;

  /// 스와이프로 뒤로가기 가능 여부
  final bool canPop;

  /// body 위젯
  final Widget? body;

  /// 하단 floating action button
  final Widget? floatingActionButton;

  /// 네비게이션 바
  final Widget? bottomNavigationBar;

  /// ### Padding, margin 등 공통 설정 값이 적용된 Scaffold
  /// 좌우 padding: 20px
  const CustomScaffold({
    super.key,
    this.appBar,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.isLoading = false,
    this.padding = 16,
    this.useSafeArea = true,
    this.canPop = true,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: canPop,
        child: Scaffold(
          appBar: appBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: backgroundColor,
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
      ),
    );
  }
}
