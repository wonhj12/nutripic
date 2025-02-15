import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraLoadingFailViewModel with ChangeNotifier {
  BuildContext context;
  CameraLoadingFailViewModel({required this.context});

  /// 다시 분석하기 버튼 클릭
  void onPressedRedo() {
    context.pop();
  }
}
