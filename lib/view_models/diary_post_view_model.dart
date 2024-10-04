import 'package:flutter/material.dart';
import 'package:nutripic/view_models/diary_camera_view_model.dart';
import 'package:nutripic/views/diary_camera_view.dart';
import 'package:provider/provider.dart';

class DiaryPostViewModel with ChangeNotifier {
  void showCameraSelectModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => DiaryCameraViewModel(),
          lazy: false,
          child: const DiaryCameraView(),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
    );
  }
}
