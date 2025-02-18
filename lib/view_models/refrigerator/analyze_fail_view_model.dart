import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnalyzeFailViewModel with ChangeNotifier {
  BuildContext context;
  AnalyzeFailViewModel({required this.context});

  /// 다시 분석하기 버튼 클릭
  void onPressedRedo() {
    context.pop();
  }
}
