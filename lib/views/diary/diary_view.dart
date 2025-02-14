import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/diary/diary_calendar.dart';
import 'package:nutripic/components/diary/diary_calendar_header.dart';
import 'package:nutripic/components/diary/diary_summary_container.dart';
import 'package:nutripic/main.dart';
import 'package:nutripic/view_models/diary/diary_view_model.dart';
import 'package:provider/provider.dart';

class DiaryView extends StatelessWidget {
  const DiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    DiaryViewModel diaryViewModel = context.watch<DiaryViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(
        title: '식단 기록',
        centerTitle: false,
        backButton: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // 캘린더 헤더
          DiaryCalendarHeader(
            onTapLeft: diaryViewModel.goToPreviousMonth,
            month: diaryViewModel.focusedDay.month,
            onTapRight: diaryViewModel.goToNextMonth,
            onTapAdd: () => diaryViewModel.navigateToDiaryPost(),
          ),

          // 캘린더 요약
          DiarySummaryContainer(
            totalDays: diaryViewModel.dayOfMonth!,
            diaryDays: diaryViewModel.diaryDays,
            username: userModel.name ?? '',
          ),
          const SizedBox(height: 10),

          // 캘린더
          DiaryCalendar(
            focusedDay: diaryViewModel.focusedDay,
            selectedDay: diaryViewModel.selectedDay,
            onDaySelected: (selectedDay, focusedDay) =>
                diaryViewModel.navigateToDiaryRecord(selectedDay),
            onPageChanged: (focusedDay) =>
                diaryViewModel.updateFocusedDay(focusedDay),
            getDiariesByDay: diaryViewModel.getDiariesByDay,
          ),
        ],
      ),
    );
  }
}
