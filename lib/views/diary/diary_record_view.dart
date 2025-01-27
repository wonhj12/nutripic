import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 20,
          ),
          onPressed: () {
            context.go('/diary');
          },
        ),
        title: GestureDetector(
          onTap: () => diaryRecordViewModel.onTapCalenderVisible(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 15,
              ),
              Text(
                diaryRecordViewModel.selectedDateString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Icon(diaryRecordViewModel.isCalendarVisible
                  ? Icons.arrow_drop_up
                  : Icons.arrow_drop_down),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add), // '추가' 아이콘
            onPressed: diaryRecordViewModel.navigateToDiaryPost,
          ),
        ],
      ),
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

          // 캘린더
          if (diaryRecordViewModel.isCalendarVisible)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
              ),
            ),
          if (diaryRecordViewModel.isCalendarVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 430,
                decoration: const BoxDecoration(
                  //color: Palette.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    TableCalendar(
                      focusedDay: diaryRecordViewModel.focusedDay,
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2100),
                      daysOfWeekHeight: 30.0,
                      rowHeight: 50,
                      selectedDayPredicate: (day) =>
                          isSameDay(diaryRecordViewModel.selectedDate, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        if (selectedDay.month ==
                            diaryRecordViewModel.focusedDay.month) {
                          diaryRecordViewModel.selectedDate = selectedDay;
                          diaryRecordViewModel.updateFocusedDay(focusedDay);
                        }
                      },
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleTextFormatter: (date, locale) {
                          return ('${date.year}년 ${date.month}월');
                        },
                        titleTextStyle: Palette.caption,
                      ),
                      calendarStyle: const CalendarStyle(
                        defaultTextStyle: TextStyle(
                          color: Palette.gray300,
                          fontSize: 9,
                        ),
                        weekendTextStyle: TextStyle(
                          color: Palette.gray300,
                          fontSize: 9,
                        ),
                        isTodayHighlighted: false,
                        selectedDecoration: BoxDecoration(
                          //color: Palette.primary,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(
                          //color: Palette.white,
                          fontSize: 9,
                        ),
                        todayDecoration: BoxDecoration(),
                      ),
                      calendarBuilders: CalendarBuilders(
                        dowBuilder: (context, day) {
                          final weekDays = ['월', '화', '수', '목', '금', '토', '일'];
                          return Center(
                            child: Text(
                              weekDays[day.weekday - 1],
                              style: Palette.caption,
                            ),
                          );
                        },
                        outsideBuilder: (context, day, focusedDay) {
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed:
                                diaryRecordViewModel.onTapCalenderVisible,
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: const BorderSide(
                                color: Palette.gray300,
                              ),
                            ),
                            child: const Text(
                              '취소',
                              style: TextStyle(
                                fontSize: 8,
                                color: Palette.gray300,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed:
                                diaryRecordViewModel.onTapCalenderVisible,
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //backgroundColor: Palette.primary,
                              disabledBackgroundColor: Palette.gray100,
                            ),
                            child: const Text(
                              '확인',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
