import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final OnDaySelected onDaySelected;
  final ValueChanged<DateTime> onPageChanged;
  final Function(DateTime) getDiariesForDay;
  const DiaryCalendar(
      {super.key,
      required this.focusedDay,
      this.selectedDay,
      required this.onDaySelected,
      required this.onPageChanged,
      required this.getDiariesForDay});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime(2024, 1, 1),
        lastDay: DateTime(2025, 12, 31),
        calendarFormat: CalendarFormat.month,
        selectedDayPredicate: (day) => selectedDay == day,
        onDaySelected: onDaySelected,
        onPageChanged: onPageChanged,
        headerVisible: false,
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: false,
          selectedDecoration: BoxDecoration(),
          selectedTextStyle: TextStyle(),
        ),
        daysOfWeekHeight: 30.0,
        rowHeight: 80,
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final weekDays = ['월', '화', '수', '목', '금', '토', '일'];
            return Center(
              child: Text(
                weekDays[day.weekday - 1], // day.weekday - 1로 요일 배열 접근
                style: Palette.caption,
              ),
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            return const SizedBox.shrink();
          },
          defaultBuilder: (context, day, focusedDay) {
            final diariesForDay = getDiariesForDay(day);

            //해당 날짜에 일기가 있는 경우
            if (diariesForDay != null && diariesForDay.isNotEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    day.day.toString(),
                    style: Palette.caption,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            FileImage(File(diariesForDay[0].imageUrl!)),
                      ),

                      // 일기 두 개 이상일때 알림
                      if (diariesForDay.length > 1)
                        Positioned(
                          top: -3,
                          right: 0,
                          //컴포넌트화
                          child: Container(
                            width: 13,
                            height: 13,
                            decoration: const BoxDecoration(
                              // 팔레트 추가
                              color: Palette.green700,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                diariesForDay.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              );
            } else {
              // 나머지 날짜들 처리
              return Column(
                children: [
                  Text(
                    day.day.toString(),
                    style: Palette.caption,
                  ),
                  //이건 디자인 봐서 할지말지
                  const SizedBox(
                    height: 5,
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Palette.gray100,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
