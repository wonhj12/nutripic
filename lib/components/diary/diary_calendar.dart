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
        daysOfWeekHeight: 25.0,
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            final weekDays = ['월', '화', '수', '목', '금', '토', '일'];
            return Center(
              child: Text(
                weekDays[day.weekday - 1], // day.weekday - 1로 요일 배열 접근
                style: Palette.body,
              ),
            );
          },
          defaultBuilder: (context, day, focusedDay) {
            final diariesForDay = getDiariesForDay(day);

            if (diariesForDay != null && diariesForDay.isNotEmpty) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    //사진 미리보기
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(diariesForDay[0].imageUrl!),
                    ),
                  ),
                  Text(
                    day.day.toString(),
                    style: const TextStyle(
                      color: Palette.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //일기 개수
                  if (diariesForDay.length > 1)
                    Positioned(
                      top: 0,
                      right: 3,
                      //컴포넌트화
                      child: Container(
                        width: 17,
                        height: 17,
                        decoration: const BoxDecoration(
                          //팔레트 추가
                          color: Color(0xFFFF5E47),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            diariesForDay.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  day.day.toString(),
                  style: Palette.body,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
