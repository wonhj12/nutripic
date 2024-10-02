import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DiaryCameraViewModel extends ChangeNotifier {
  File? _image; // 선택된 이미지를 저장할 변수
  final ImagePicker _picker = ImagePicker();

  File? get image => _image;

  // 이미지 선택 함수 (카메라/갤러리)
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }
}
