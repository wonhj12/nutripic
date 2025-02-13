import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;
  final Function(DateTime) getDiariesByDay;
  const DiaryCalendar(
      {super.key,
      required this.focusedDay,
      this.selectedDay,
      required this.onDaySelected,
      required this.onPageChanged,
      required this.getDiariesByDay});

  // 날짜에 따라 원형 이미지 불러오는 위젯
  Widget diaryCircleAvatar(List<dynamic> diariesForDay) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: diariesForDay.isNotEmpty
              ? const NetworkImage(
                  "https://cphoto.asiae.co.kr/listimglink/1/2020011513515297802_1579063912.jpg",
                )
              //backgroundImage: FileImage(File(diariesForDay[0].imageUrl!)),
              : null,
          backgroundColor: diariesForDay.isEmpty ? Colors.transparent : null,
        ),
        if (diariesForDay.length > 1)
          Positioned(
            top: -3,
            right: -3,
            child: Container(
              width: 21,
              height: 19,
              decoration: BoxDecoration(
                color: Palette.gray00,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Palette.green600,
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Text(
                  diariesForDay.length.toString(),
                  style: const TextStyle(
                    color: Palette.green600,
                    fontSize: 7,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

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
                weekDays[day.weekday - 1],
                style: const TextStyle(
                  color: Palette.gray700,
                  fontSize: 9,
                ),
              ),
            );
          },

          // 다른 달 날짜 처리
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
                      color: Palette.gray200,
                      fontSize: 7,
                      fontWeight: FontWeight.w500),
                ),
              ],
            );
          },

          // 오늘 날짜 처리
          todayBuilder: (context, day, focusedDay) {
            final diariesForDay = getDiariesByDay(day);
            return Column(
              children: [
                const SizedBox(height: 5),
                diaryCircleAvatar(diariesForDay),
                const SizedBox(height: 5),
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

          // 나머지 날짜 처리
          defaultBuilder: (context, day, focusedDay) {
            final diariesForDay = getDiariesByDay(day);

            return Column(
              children: [
                const SizedBox(height: 5),
                diaryCircleAvatar(diariesForDay),
                const SizedBox(height: 5),
                Text(
                  day.day.toString(),
                  style: const TextStyle(
                    color: Palette.gray900,
                    fontSize: 7,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
