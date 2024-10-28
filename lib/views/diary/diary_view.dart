import 'package:flutter/material.dart';
import 'package:nutripic/components/custom_app_bar.dart';
import 'package:nutripic/components/custom_scaffold.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/diary/diary_view_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

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
    DateTime? _selectedDay;

    return Scaffold(
      appBar: const CustomAppBar(backButton: false),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: diaryViewModel.goToPreviousMonth,
              ),
              Text(
                '${diaryViewModel.focusedDay.month}월',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: diaryViewModel.goToNextMonth,
              ),
            ],
          ),
          TableCalendar(
            focusedDay: diaryViewModel.focusedDay,
            firstDay: DateTime(2024, 1, 1),
            lastDay: DateTime(2025, 12, 31),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) {
              return _selectedDay == day;
            },
            onDaySelected: (selectedDay, focusedDay) {
              _selectedDay = selectedDay;
              diaryViewModel.showDiaryRecordModal(selectedDay);
            },
            onPageChanged: (focusedDay) {
              diaryViewModel
                  .updateFocusedDay(focusedDay); // 페이지 변경 시에만 _focusedDay 업데이트
            },

            // headerStyle: HeaderStyle(
            //   formatButtonVisible: false,
            //   titleCentered: false,
            //   titleTextFormatter: (date, locale) => '${date.month}월',
            //   titleTextStyle: Palette.subtitle,
            //   leftChevronPadding: EdgeInsets.only(right: 4.0), // 오른쪽 여백만 설정
            //   rightChevronPadding: EdgeInsets.only(left: 4.0),
            // ),
            headerVisible: false,
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: false,
              selectedDecoration: BoxDecoration(),
              selectedTextStyle: TextStyle(),
            ),
            //요일 간격
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
                final diariesForDay = diaryViewModel.getDiariesForDay(day);

                if (diariesForDay.isNotEmpty) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        //사진 미리보기
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              NetworkImage(diariesForDay[0].imageUrl!),
                        ),
                      ),
                      Text(
                        day.day.toString(),
                        style: const TextStyle(
                          //팔레트 추가
                          color: Colors.white,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          diaryViewModel.showCameraSelectModal();
        },
      ),
    );
  }
}
