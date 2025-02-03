import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/diary/diary_calendar.dart';
import 'package:nutripic/components/diary/diary_calendar_header.dart';
import 'package:nutripic/components/diary/diary_summary_container.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/utils/palette.dart';
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
    DateTime? selectedDay;

    return CustomScaffold(
      appBar: AppBar(
        title: const Text(
          "식단 기록",
          style: TextStyle(
            color: Palette.gray700,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Palette.gray100,
            height: 1.0,
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),

          //커스텀 헤더
          DiaryCalendarHeader(
            onTapLeft: diaryViewModel.goToPreviousMonth,
            month: diaryViewModel.focusedDay.month,
            onTapRight: diaryViewModel.goToNextMonth,
            onTapAdd: () {
              diaryViewModel.navigateToDiaryPost(DateTime.now());
            },
          ),

          //한 달 요약
          DiarySummaryContainer(
            percent: diaryViewModel.getProperMealPercentage(),
            type: diaryViewModel.getProperMealPercentage() > 0.3
                ? StatusType.normal
                : StatusType.low,
            totalDays: diaryViewModel.getTotalDaysInMonth(),
            diaryDays: diaryViewModel.getDiariesForMonth(),
            username: "권지용",
          ),
          const SizedBox(
            height: 10,
          ),

          //캘린더
          DiaryCalendar(
            focusedDay: diaryViewModel.focusedDay,
            selectedDay: selectedDay,
            onDaySelected: (selectedDay, focusedDay) {
              if (selectedDay.month == diaryViewModel.focusedDay.month) {
                selectedDay = selectedDay;
                // if (diaryViewModel.getDiariesForDay(selectedDay).isEmpty) {
                //   diaryViewModel.navigateToDiaryPost(selectedDay);
                // } else {
                //   diaryViewModel.navigateToDiaryRecord(selectedDay);
                // }
                diaryViewModel.navigateToDiaryRecord(selectedDay);
              }
            },
            onPageChanged: (focusedDay) {
              diaryViewModel.updateFocusedDay(focusedDay);
            },
            getDiariesForDay: diaryViewModel.getDiariesForDay,
          ),
        ],
      ),

      //게시글 추가 버튼 스택
      // floatingActionButton: Stack(
      //   children: [
      //     if (diaryViewModel.clicked)
      //       GestureDetector(
      //         onTap: diaryViewModel.floatingButtonClick,
      //       ),

      //     //카메라 선택 버튼
      //     CustomFloatingActionButton(
      //       heroTag: "cameraTag",
      //       type: ButtonType.gray,
      //       icon: Icons.camera_alt,
      //       onPressed: () {
      //         diaryViewModel.imagePick(ImageSource.camera);
      //       },
      //       animatedPositionBottom: diaryViewModel.clicked ? 130 : 0,
      //       opacity: diaryViewModel.clicked ? 1.0 : 0.0,
      //     ),

      //     //갤러리 선택 버튼
      //     CustomFloatingActionButton(
      //       heroTag: "galleryTag",
      //       type: ButtonType.gray,
      //       icon: Icons.photo,
      //       onPressed: () {
      //         diaryViewModel.imagePick(ImageSource.gallery);
      //       },
      //       animatedPositionBottom: diaryViewModel.clicked ? 65 : 0,
      //       opacity: diaryViewModel.clicked ? 1.0 : 0.0,
      //     ),

      //     //선택버튼
      //     CustomFloatingActionButton(
      //       heroTag: "mainTag",
      //       type: ButtonType.green,
      //       icon: diaryViewModel.clicked ? Icons.close : Icons.add,
      //       onPressed: diaryViewModel.floatingButtonClick,
      //     ),
      //   ],
      // ),
    );
  }
}
