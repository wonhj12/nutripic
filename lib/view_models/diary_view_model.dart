import 'package:flutter/material.dart';
import 'package:nutripic/models/diary_model.dart';

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
}
