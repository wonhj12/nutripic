import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

/// 메시지만 표시하는 스낵바 컴포넌트
/// <br /> `ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar().show(message: ''));`
class CustomSnackbar {
  SnackBar show({required String message, int duration = 2}) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Palette.gray900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(
        message,
        style: Palette.body2,
      ),
      duration: Duration(seconds: duration),
    );
  }
}
