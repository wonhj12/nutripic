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
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(),
          selectedTextStyle: TextStyle(),
        ),
        daysOfWeekHeight: 40,
        rowHeight: 70,
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final weekDays = ['월', '화', '수', '목', '금', '토', '일'];
            return Center(
              child: Text(
                weekDays[day.weekday - 1], // day.weekday - 1로 요일 배열 접근
                style: const TextStyle(
                  color: Palette.gray900,
                  fontSize: 9,
                ),
              ),
            );
          },
          outsideBuilder: (context, day, focusedDay) {
            return Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  day.day.toString(),
                  style: const TextStyle(
                      color: Palette.gray300,
                      fontSize: 7,
                      fontWeight: FontWeight.w500),
                ),
              ],
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 28,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Palette.green500,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: const TextStyle(
                        color: Palette.gray00,
                        fontSize: 7,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          defaultBuilder: (context, day, focusedDay) {
            final diariesForDay = getDiariesForDay(day);

            //해당 날짜에 일기가 있는 경우
            if (diariesForDay != null && diariesForDay.isNotEmpty) {
              return Column(
                children: [
                  const SizedBox(
                    height: 5,
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
                            width: 21,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Palette.gray00,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Palette.green500,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                diariesForDay.length.toString(),
                                style: const TextStyle(
                                  color: Palette.green500,
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
                  Text(
                    day.day.toString(),
                    style: const TextStyle(
                        color: Palette.gray900,
                        fontSize: 7,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              );
            } else {
              // 나머지 날짜들 처리
              return Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    day.day.toString(),
                    style: const TextStyle(
                        color: Palette.gray900,
                        fontSize: 7,
                        fontWeight: FontWeight.w500),
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
