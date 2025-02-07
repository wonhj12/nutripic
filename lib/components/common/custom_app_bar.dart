import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/utils/palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 제목
  final String? title;

  /// 제목 위젯
  final Widget? titleWidget;

  /// 제목 중앙 정렬 여부
  final bool centerTitle;

  /// 뒤로가기 버튼 표시 여부
  final bool backButton;

  /// 닫기 버튼으로 표시 여부
  final bool closeButton;

  /// 뒤로가기 클릭시 호출 함수
  final Function()? onPressedLeading;

  /// 하단 구분선 표시 여부
  final bool underLine;

  /// 우측 표시 위젯
  final List<Widget>? actions;

  /// ### AppBar에서 필요한 기능들을 적용한 위젯
  /// `title` : AppBar 타이틀
  ///
  /// `titleWidget` : `title` 대신 사용하는 위젯
  /// - `title`이 `null`인 경우 적용 가능
  ///
  /// `centerTitle` : 타이틀 중앙 정렬 여부
  /// - `false`인 경우 우측에 표시
  ///
  /// `backButton` : 뒤로가기 버튼 표시 여부
  /// - 뒤로가기 버튼이 표시되는 경우가 더 많아서 기본 값은 `true`로 설정
  ///
  /// `closeButton` : 닫기 버튼 표시 여부
  /// - `backButton`이 활성화 상태일때만 사용 가능
  /// - 기본 값은 `false`로 설정 (뒤로가기 버튼이 더 우선 순위)
  ///
  /// `onPressedLeading` : 뒤로가기 또는 닫기 버튼을 클릭했을 때 호출되는 함수
  /// - `null`이면 `context.pop()`이 기본으로 실행 됨
  ///
  /// `underLine` : 하단 구분선 표시 여부
  /// - 기본 값은 `true`로 설정
  ///
  /// `actions` : 앱바 우측에 표시되는 위젯 리스트
  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.backButton = true,
    this.onPressedLeading,
    this.closeButton = false,
    this.underLine = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : titleWidget,
      centerTitle: centerTitle,
      leading: backButton
          ? closeButton
              ? IconButton(
                  onPressed: onPressedLeading ?? () => context.pop(),
                  icon: const Icon(Icons.close_rounded, size: 24),
                )
              : IconButton(
                  onPressed: onPressedLeading ?? () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
                )
          : null,
      actions: [
        ...?actions,
        const Padding(padding: EdgeInsets.only(right: 16)),
      ],
      shape: underLine
          ? const Border(
              bottom: BorderSide(
                color: Palette.gray100,
                width: 1,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
