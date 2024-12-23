import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/custom_floating_action_button.dart';
import 'package:nutripic/components/diary/diary_calendar.dart';
import 'package:nutripic/components/diary/diary_calendar_header.dart';
import 'package:nutripic/components/diary/diary_summary_container.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/view_models/diary/diary_view_model.dart';
import 'package:provider/provider.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  @override
  Widget build(BuildContext context) {
    DiaryViewModel diaryViewModel = context.watch<DiaryViewModel>();
    //DateTime _focusedDay = DateTime.now();
    DateTime? selectedDay;

    return CustomScaffold(
      appBar: const CustomAppBar(backButton: false),
      body: Column(
        children: [
          //커스텀 헤더
          DiaryCalendarHeader(
              onTapLeft: diaryViewModel.goToPreviousMonth,
              month: diaryViewModel.focusedDay.month,
              onTapRight: diaryViewModel.goToNextMonth),
          const SizedBox(
            height: 10,
          ),

          //한 달 요약
          DiarySummaryContainer(
            percent: diaryViewModel.getProperMealPercentage(),
            type: diaryViewModel.getProperMealPercentage() > 0.3
                ? StatusType.normal
                : StatusType.low,
            totalDays: diaryViewModel.getTotalDaysInMonth(),
            diaryDays: diaryViewModel.getDiariesForMonth(),
          ),
          const SizedBox(
            height: 20,
          ),

          //캘린더
          DiaryCalendar(
            focusedDay: diaryViewModel.focusedDay,
            selectedDay: selectedDay,
            onDaySelected: (selectedDay, focusedDay) {
              selectedDay = selectedDay;
              diaryViewModel.showDiaryRecordModal(selectedDay);
            },
            onPageChanged: (focusedDay) {
              diaryViewModel.updateFocusedDay(focusedDay);
            },
            getDiariesForDay: diaryViewModel.getDiariesForDay,
          ),
        ],
      ),

      //게시글 추가 버튼 스택
      floatingActionButton: Stack(
        children: [
          if (diaryViewModel.clicked)
            //화면 회색 블러 처리 어케함..
            GestureDetector(
              onTap: diaryViewModel.floatingButtonClick,
            ),

          //카메라 선택 버튼
          CustomFloatingActionButton(
            heroTag: "cameraTag",
            type: ButtonType.gray,
            icon: Icons.camera_alt,
            onPressed: () {
              diaryViewModel.imagePick(ImageSource.camera);
            },
            animatedPositionBottom: diaryViewModel.clicked ? 130 : 0,
            opacity: diaryViewModel.clicked ? 1.0 : 0.0,
          ),

          //갤러리 선택 버튼
          CustomFloatingActionButton(
            heroTag: "galleryTag",
            type: ButtonType.gray,
            icon: Icons.photo,
            onPressed: () {
              diaryViewModel.imagePick(ImageSource.gallery);
            },
            animatedPositionBottom: diaryViewModel.clicked ? 65 : 0,
            opacity: diaryViewModel.clicked ? 1.0 : 0.0,
          ),

          //선택버튼
          CustomFloatingActionButton(
            heroTag: "mainTag",
            type: ButtonType.green,
            icon: diaryViewModel.clicked ? Icons.close : Icons.add,
            onPressed: diaryViewModel.floatingButtonClick,
          ),
        ],
      ),
    );
  }
}
