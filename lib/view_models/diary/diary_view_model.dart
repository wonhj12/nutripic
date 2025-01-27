import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/objects/diary.dart';

class DiaryViewModel extends ChangeNotifier {
  DiaryModel diaryModel;
  BuildContext context;
  DiaryViewModel({required this.diaryModel, required this.context});

  final ImagePicker _picker = ImagePicker();

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;

  bool clicked = false;
  int currentIndex = 0;
  bool isLoading = false;

  Future<void> updateDiaries() async {
    isLoading = true;
    notifyListeners();

    try {
      await diaryModel.getDiaries(DateTime.now().month - focusedDay.month);
    } catch (e) {
      debugPrint('Error fetching diaries: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// 이전달 이동 함수
  Future<void> goToPreviousMonth() async {
    if (focusedDay.month == 1) {
      focusedDay = DateTime(focusedDay.year - 1, 12);
    } else {
      focusedDay = DateTime(focusedDay.year, focusedDay.month - 1);
    }

    //updateDiaries();
  }

  /// 다음달 이동 함수
  Future<void> goToNextMonth() async {
    if (focusedDay.month > 11) {
      focusedDay = DateTime(focusedDay.year + 1, 1);
    } else {
      focusedDay = DateTime(focusedDay.year, focusedDay.month + 1);
    }

    //updateDiaries();
  }

  void updateFocusedDay(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
    notifyListeners();
  }

  /// 선택된 날짜의 일기 불러오기
  List<Diary> getDiariesForDay(DateTime date) {
    return diaryModel.diariesForMonth
        .where((diary) => diary.date == date)
        .toList();
  }

  /// 다이어리 추가 화면으로 이동
  void navigateToDiaryPost(DateTime selectedDay) {
    context.go('/diary/post', extra: selectedDay);
  }

  /// 다이어리 리스트 화면으로 이동
  void navigateToDiaryRecord(DateTime selectedDay) {
    context.go('/diary/record', extra: selectedDay);
  }

  /// 일기 있는 날짜수 반환
  int getDiariesForMonth() {
    final diariesForMonth = diaryModel.diariesForMonth
        .where((diary) =>
            diary.date?.year == focusedDay.year &&
            diary.date?.month == focusedDay.month)
        .map((diary) => diary.date?.day)
        .toSet();
    return diariesForMonth.length;
  }

  /// 이번 달 날짜수 반환
  int getTotalDaysInMonth() {
    return DateTime(focusedDay.year, focusedDay.month + 1, 0)
        .day; // 다음 달 0일로 설정해 해당 달의 마지막 날 계산
  }

  /// 건강한 식사 비율 반환
  double getProperMealPercentage() {
    final int totalDays = getTotalDaysInMonth();
    final int properMealDays = getDiariesForMonth();
    if (totalDays == 0) return 0.0;
    return properMealDays / totalDays;
  }

  ///사진 추가 방식 선택
  // void floatingButtonClick() {
  //   clicked = !clicked;
  //   notifyListeners();
  // }

  /// 카메라/갤러리 선택 후 사진 촬영
  // Future<void> imagePick(ImageSource source) async {
  //   // 새로 등록시 기존 선택 되어잇는 diary 제거
  //   diaryModel.reset();

  //   // 이미지 촬영 / 갤러리에서 이미지 불러오기
  //   final pickedFile = await _picker.pickImage(source: source);

  //   // 사진 촬영 완료 후 새 diary 생성, 사진 등록
  //   if (pickedFile != null) {
  //     final image = File(pickedFile.path);
  //     diaryModel.diary = Diary(imageUrl: image.path);

  //     if (context.mounted) {
  //       context.go('/diary/post');
  //     }
  //   }
  // }

  /// 일기 목록 모달 보여주기
  // void showDiaryRecordModal(DateTime date) {
  //   final diaryRecords = getDiariesForDay(date);
  //   if (diaryRecords.isEmpty) return;

  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return ChangeNotifierProvider(
  //         create: (context) => DiaryRecordViewModel(),
  //         child: const DiaryRecordView(),
  //       );
  //     },
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(25.0),
  //       ),
  //     ),
  //   );
  // }
}
