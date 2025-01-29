import 'package:flutter/material.dart';

/// `Spacer()` 사용이 가능하도록 화면 크기 계산하는 Scroll View
class CustomSingleChildScrollView extends StatelessWidget {
  final List<Widget> children;
  const CustomSingleChildScrollView({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          )),
        ),
      ),
    );
  }
}
