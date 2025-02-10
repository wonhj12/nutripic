import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/objects/diary.dart';
import 'package:nutripic/utils/api.dart';
import 'package:nutripic/utils/palette.dart';

class DiaryRecordViewModel extends ChangeNotifier {
  DiaryModel diaryModel;
  BuildContext context;
  DateTime selectedDate;
  DateTime focusedDay = DateTime.now();
  bool isLoading = false;
  bool isCalendarVisible = false;

  DiaryRecordViewModel({
    required this.diaryModel,
    required this.context,
    required this.selectedDate,
  }) {
    getDiaries();
  }

  /// 캘린더 표시 함수
  void onTapCalenderVisible() async {
    isCalendarVisible = !isCalendarVisible;
    notifyListeners();
  }

  ///게시글 추가 화면으로 이동
  void navigateToDiaryPost() {
    context.go('/diary/post',
        extra: {'diaryId': null, 'selectedDate': selectedDate});
  }

  ///선택 날짜 변경 함수
  void updateSelectedDate(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    notifyListeners();
  }

  void updateFocusedDay(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
    notifyListeners();
  }

  String selectedDateString() {
    return '${selectedDate.month}월 ${selectedDate.day}일';
  }

  String getTime(DateTime time) {
    if (time.hour < 12) {
      return '오전 ${time.hour.toString().padLeft(2, '0')} : ${time.minute.toString().padLeft(2, '0')}';
    } else {
      return '오후 ${(time.hour - 12).toString().padLeft(2, '0')} : ${time.minute.toString().padLeft(2, '0')}';
    }
  }

  /// 다이어리 업데이트
  Future<void> getDiaries() async {
    isLoading = true;
    notifyListeners();

    try {
      await diaryModel.getDiariesForDay(
          DateTime.now().month - focusedDay.month, selectedDate.day);
    } catch (e) {
      debugPrint('Error fetching diaries: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  List<Diary> getDiariesForDay() {
    return diaryModel.diariesForDay.toList();
  }

  Future<void> onTapPatch(int diaryId) async {
    print(diaryId);
    context.go('/diary/post', extra: {
      "selectedDate": selectedDate,
      "diaryId": diaryId,
    });
  }

  Future<void> onTapDelete(int diaryId) async {
    await API.deleteDiary(diaryId);
    getDiaries();
    debugPrint('Diary with ID $diaryId has been removed.');
  }

  // Future<void> getDiaryRecord() async {
  //   isLoading = true;
  //   // 서버에서 각 날짜별로 달라고 해야겠다...
  //   final response =
  //       await API.getDiariesForMonth(DateTime.now().month - selectedDate.month);
  //   final List<dynamic> data = response.data;
  //   final List<Diary> diariesForMonth =
  //       data.map((item) => Diary.fromJson(item)).toList();

  //   final List<int?> diaryIdsForSelectedDate = diariesForMonth
  //       .where((diary) =>
  //           diary.date?.year == selectedDate.year &&
  //           diary.date?.month == selectedDate.month &&
  //           diary.date?.day == selectedDate.day)
  //       .map((diary) => diary.diaryId)
  //       .toList();

  //   for (final id in diaryIdsForSelectedDate) {
  //     if (id == null) continue; // ID가 null인 경우 건너뜀

  //     try {
  //       final diaryResponse = await API.getDiariesForDay(id,day);
  //       final Diary diary = Diary.fromJson(diaryResponse.data);
  //       if (!todayDiaries
  //           .any((existingDiary) => existingDiary.diaryId == diary.diaryId)) {
  //         todayDiaries.add(diary);
  //         debugPrint('DiaryToday added: ${diary.diaryId}, ${diary.content}');
  //         debugPrint('Diary Details for ID $id: ${diaryResponse.data}');
  //       }
  //     } catch (e) {
  //       debugPrint('Error fetching diary with ID $id: $e');
  //     }
  //   }

  //   notifyListeners();
  // }

  // Future<void> deleteDiaryRecord(int diaryId) async {
  //   await deleteDiaryRecord(diaryId);
  //   await getDiaryRecord();
  //   debugPrint('Diary with ID $diaryId has been removed.');
  // }
}
