import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/date_picker.dart';
import 'package:nutripic/view_models/diary_camera_view_model.dart';
import 'package:nutripic/views/diary_camera_view.dart';
import 'package:provider/provider.dart';

class DiaryPostViewModel with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

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

  void onTapTimePicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return DatePicker(
            initialDate: _selectedDate,
            onDateSelected: (DateTime date) {
              _selectedDate = date;
              notifyListeners();
            },
          );
        });
  }

  void submitPost(BuildContext context) {
    //전송
    context.go('/diary');
  }
}
