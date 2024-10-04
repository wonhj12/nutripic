import 'package:flutter/material.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/view_models/diary_camera_view_model.dart';
import 'package:nutripic/views/diary_camera_view.dart';
import 'package:provider/provider.dart';

class DiaryViewModel extends ChangeNotifier {
  DateTime? _selectedDay;
  DateTime? get selectedDay => _selectedDay;

  //DiaryModel diaryModel;
  //BuildContext context;
  //DiaryViewModel({required this.diaryModel, required this.context});

  //Map<DateTime, List<DiaryModel>> _diarylist = {};
  final Map<DateTime, List<DiaryModel>> _diarylist = {
    DateTime.utc(2024, 10, 22): [
      DiaryModel(diaryId: '1', content: '일'),
      DiaryModel(diaryId: '2', content: '이'),
    ],
    DateTime.utc(2024, 10, 24): [
      DiaryModel(
        diaryId: '3',
        content: '삼',
      )
    ],
  };

  Map<DateTime, List<DiaryModel>> get diarylist => _diarylist;

  void updateSelectDay(DateTime date) {
    _selectedDay = date;
    notifyListeners();
  }

  bool isSameDay(DateTime day) {
    return _selectedDay == day;
  }

  List<DiaryModel> getDiariesForDay(DateTime day) {
    return diarylist[day] ?? [];
  }

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
