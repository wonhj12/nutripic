import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/objects/diary.dart';

class DiaryViewModel extends ChangeNotifier {
  DiaryModel diaryModel;
  BuildContext context;
  DiaryViewModel({
    required this.diaryModel,
    required this.context,
  }) {
    update();
  }

  /// 사용자가 보고 있는 날짜
  DateTime focusedDay = DateTime.now();

  /// 사용자가 선택한 날짜
  DateTime? selectedDay;

  /// 현재 달의 날짜 수
  int? dayOfMonth;

  /// 현재 달에서 다이어리가 있는 날짜 수
  int diaryDays = 0;

  /// 업데이트
  void update() async {
    getDiaries();
    dayOfMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0).day;
    notifyListeners();
  }

  /// 다이어리 및 날짜 별 다이어리 갯수 불러오기
  Future<void> getDiaries() async {
    await diaryModel.getDiariesForMonth(
        (DateTime.now().year - focusedDay.year) * 12 +
            DateTime.now().month -
            focusedDay.month);

    diaryDays = diaryModel.diariesForMonth
        .where((diary) =>
            diary.date?.year == focusedDay.year &&
            diary.date?.month == focusedDay.month)
        .map((diary) => diary.date?.day)
        .toSet()
        .length;

    notifyListeners();
  }

  /// 이전 달로 이동하는 함수
  Future<void> goToPreviousMonth() async {
    if (focusedDay.month == 1) {
      focusedDay = DateTime(focusedDay.year - 1, 12);
    } else {
      focusedDay = DateTime(focusedDay.year, focusedDay.month - 1);
    }

    update();
  }

  /// 이전 달로 이동하는 함수
  Future<void> goToNextMonth() async {
    if (focusedDay.month == 12) {
      focusedDay = DateTime(focusedDay.year + 1, 1);
    } else {
      focusedDay = DateTime(focusedDay.year, focusedDay.month + 1);
    }

    update();
  }

  /// focusedDay 업데이트하는 함수
  void updateFocusedDay(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
    update();
  }

  /// 선택된 날짜의 일기 불러오는 함수
  List<Diary> getDiariesByDay(DateTime date) {
    return diaryModel.diariesForMonth.where((diary) {
      return diary.date?.year == date.year &&
          diary.date?.month == date.month &&
          diary.date?.day == date.day;
    }).toList();
  }

  /// 다이어리 등록 화면으로 이동하는 함수
  void navigateToDiaryPost() async {
    await context.push(
      '/diary/post',
      extra: {'diaryId': null, 'selectedDay': DateTime.now()},
    );
    update();
  }

  /// 다이어리 리스트 화면으로 이동하는 함수
  void navigateToDiaryRecord(DateTime selectedDay) async {
    await context.push('/diary/record', extra: selectedDay);
    update();
  }
}
