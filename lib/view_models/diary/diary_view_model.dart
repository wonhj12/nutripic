import 'package:flutter/material.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/view_models/diary/diary_camera_view_model.dart';
import 'package:nutripic/view_models/diary/diary_record_view_model.dart';
import 'package:nutripic/views/diary/diary_camera_view.dart';
import 'package:nutripic/views/diary/diary_record_view.dart';
import 'package:provider/provider.dart';

class DiaryViewModel extends ChangeNotifier {
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

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
    _selectedDate = date;
    notifyListeners();
  }

  bool isSameDay(DateTime date) {
    return _selectedDate == date;
  }

  List<DiaryModel> getDiariesForDay(DateTime date) {
    return diarylist[date] ?? [];
  }

  void showCameraSelectModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => DiaryCameraViewModel(),
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

  void showDiaryRecordModal(BuildContext context, DateTime date) {
    final diaryRecords = getDiariesForDay(date);
    if (diaryRecords.isEmpty) return;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => DiaryRecordViewModel(diaryRecords),
          child: const DiaryRecordView(),
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
