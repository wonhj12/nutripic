import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/diary/calendar_scaffold.dart';
import 'package:nutripic/components/diary/diary_card.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/diary/diary_record_view_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryRecordView extends StatelessWidget {
  const DiaryRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    DiaryRecordViewModel diaryRecordViewModel =
        context.watch<DiaryRecordViewModel>();
    // if (!diaryRecordViewModel.isLoading &&
    //     diaryRecordViewModel.todayDiaries.isEmpty) {
    //   diaryRecordViewModel.getDiaryRecord();
    // }
    return CalendarScaffold(
      body: Stack(
        children: [
          //게시글 리스트
          ListView.builder(
            itemCount: diaryRecordViewModel.todayDiaries.length,
            itemBuilder: (context, index) {
              final diary = diaryRecordViewModel.todayDiaries[index];
              return DiaryCard(
                diary: diary,
                onPressed: () =>
                    diaryRecordViewModel.showOptionModal(diary.diaryId!),
              );
            },
          ),
        ],
      ),
      isCalendarVisible: diaryRecordViewModel.isCalendarVisible,
      selectedDateString: diaryRecordViewModel.selectedDateString(),
      onTapCalenderVisible: diaryRecordViewModel.onTapCalenderVisible,
      onPressedAdd: diaryRecordViewModel.navigateToDiaryPost,
      selectedDate: diaryRecordViewModel.selectedDate,
      focusedDay: diaryRecordViewModel.focusedDay,
      updateFocusedDay: diaryRecordViewModel.updateFocusedDay,
      addButton: true,
    );
  }
}
