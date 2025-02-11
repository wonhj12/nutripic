import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/utils/api.dart';

class DiaryRecordViewModel extends ChangeNotifier {
  DiaryModel diaryModel;
  BuildContext context;

  DiaryRecordViewModel({
    required this.diaryModel,
    required this.context,
    required this.selectedDay,
  }) {
    getDiaries();
  }

  /// 사용자가 보고 있는 날짜
  DateTime focusedDay = DateTime.now();

  /// 사용자가 선택한 날짜
  DateTime selectedDay;

  /// 캘린더 표시 여부
  bool isCalendarVisible = false;

  /// 캘린더 표시 함수
  void onTapCalenderVisible() async {
    isCalendarVisible = !isCalendarVisible;
    notifyListeners();
  }

  ///게시글 추가 화면으로 이동
  void navigateToDiaryPost() async {
    await context.push('/diary/post',
        extra: {'diaryId': null, 'selectedDay': selectedDay});

    getDiaries();
  }

  /// selectedDay 변경 함수
  void updateSelectedDay(DateTime newSelectedDay) {
    selectedDay = newSelectedDay;
    notifyListeners();
  }

  /// focusedDay 변경 함수
  void updateFocusedDay(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
    notifyListeners();
  }

  /// 다이어리  불러오기
  Future<void> getDiaries() async {
    await diaryModel.getDiariesForDay(
        DateTime.now().month - focusedDay.month, selectedDay.day);

    notifyListeners();
  }

  /// 다이어리 수정 화면(=등록)으로 이동 함수
  void onTapPatch(int diaryId) async {
    await context.push('/diary/post', extra: {
      "selectedDay": selectedDay,
      "diaryId": diaryId,
    });
  }

  /// 다이어리 삭제 함수
  Future<void> onTapDelete(int diaryId) async {
    await API.deleteDiary(diaryId);
    getDiaries();
    debugPrint('Diary with ID $diaryId has been removed.');
  }
}
