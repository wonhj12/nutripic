import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/diary/diary_calendar.dart';
import 'package:nutripic/components/diary/diary_calendar_header.dart';
import 'package:nutripic/components/diary/diary_summary_container.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/diary/diary_view_model.dart';
import 'package:provider/provider.dart';

class DiaryView extends StatelessWidget {
  const DiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    DiaryViewModel diaryViewModel = context.watch<DiaryViewModel>();

    return CustomScaffold(
      appBar: AppBar(
        title: const Text(
          "  식단 기록",

          //TODO: 텍스트 스타일 통일하기
          style: TextStyle(
            color: Palette.gray700,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: false,

        //구분선
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Palette.gray100,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),

          //캘린더 헤더
          DiaryCalendarHeader(
            onTapLeft: diaryViewModel.goToPreviousMonth,
            month: diaryViewModel.focusedDay.month,
            onTapRight: diaryViewModel.goToNextMonth,
            onTapAdd: () => diaryViewModel.navigateToDiaryPost(),
          ),

          //캘린더 요약
          DiarySummaryContainer(
            totalDays: diaryViewModel.dayOfMonth!,
            diaryDays: diaryViewModel.diaryDays!,

            //TODO : UserName 불러오기
            username: "권지용",
          ),
          const SizedBox(
            height: 10,
          ),

          //캘린더
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
