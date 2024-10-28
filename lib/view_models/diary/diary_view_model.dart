import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutripic/components/select_camera_modal.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/objects/diary.dart';
import 'package:nutripic/view_models/diary/diary_record_view_model.dart';
import 'package:nutripic/views/diary/diary_record_view.dart';
import 'package:provider/provider.dart';

class DiaryViewModel extends ChangeNotifier {
  DiaryModel diaryModel;
  BuildContext context;
  DiaryViewModel({required this.diaryModel, required this.context});

  final ImagePicker _picker = ImagePicker();

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDate;

  void goToPreviousMonth() {
    if (focusedDay.month < 2) {
      focusedDay = DateTime(focusedDay.year - 1, 12);
    } else {
      focusedDay = DateTime(focusedDay.year, focusedDay.month - 1);
    }
    notifyListeners();
  }

  void goToNextMonth() {
    if (focusedDay.month > 11) {
      focusedDay = DateTime(focusedDay.year + 1, 1);
    } else {
      focusedDay = DateTime(focusedDay.year, focusedDay.month + 1);
    }

    notifyListeners();
  }

  void updateFocusedDay(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
    notifyListeners();
  }

  /// 선택된 날짜의 일기 불러오기
  List<Diary> getDiariesForDay(DateTime date) {
    return diaryModel.diaries.where((diary) => diary.date == date).toList();
  }

  List<Diary> getDiariesForMonth(int year, int month) {
    return diaryModel.diaries
        .where(
            (diary) => diary.date?.year == year && diary.date?.month == month)
        .toList();
  }

  /// 카메라/갤러리 선택 후 사진 촬영
  Future<void> showCameraSelectModal() async {
    // 모달 띄워서 사진 업로드 방식 선택 (카메라, 갤러리)
    final mode = await selectCameraModal(context);

    if (mode != null) {
      // 새로 등록시 기존 선택 되어잇는 diary 제거
      diaryModel.reset();

      // 이미지 촬영 / 갤러리에서 이미지 불러오기
      final pickedFile = await _picker.pickImage(source: mode);

      // 사진 촬영 완료 후 새 diary 생성, 사진 등록
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        diaryModel.diary = Diary(imageUrl: image.path);

        if (context.mounted) {
          context.go('/diary/post');
        }
      }
    }
  }

  /// 일기 목록 모달 보여주기
  void showDiaryRecordModal(DateTime date) {
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
