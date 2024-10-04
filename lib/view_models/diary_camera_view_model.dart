import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class DiaryCameraViewModel extends ChangeNotifier {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  File? get image => _image;

  // 이미지 선택 함수 (카메라/갤러리)
  Future<void> getImage(ImageSource source, BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();

      //이미지가 선택된 경우 이동
      context.go('/diary/post', extra: _image!.path);
    }
  }

  void closeCameraSelectModal(BuildContext context) {
    Navigator.pop(context);
    notifyListeners();
  }
}
