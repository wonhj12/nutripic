import 'package:flutter/material.dart';
import 'package:nutripic/models/diary_model.dart';

class DiaryRecordViewModel extends ChangeNotifier {
  final List<DiaryModel> diaryRecords;
  DiaryRecordViewModel(this.diaryRecords);
  List<DiaryModel> get records => diaryRecords;
}
