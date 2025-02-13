import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/common/loading_screen.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScaffold extends StatefulWidget {
  /// 수정화면 구분
  final bool isPatch;

  /// 추가 버튼
  final bool addButton;

  /// 현재 보여주는 날짜
  DateTime focusedDay;

  ///선택한 날짜
  DateTime selectedDay;

  /// 현재 보여주는 날짜 업데이트 함수
  final Function? updateFocusedDay;

  ///선택한 날짜 업데이트 함수
  final Function? updateSelectedDate;

  /// 캘린더 표시 선택 함수
  final Function? onTapCalenderVisible;

  /// 캘린더 표시 여부
  final bool isCalendarVisible;

  ///body 위젯
  final Widget? body;

  /// 추가 버튼 누름
  final Function? onPressedAdd;

  /// 네비게이션 바
  final Widget? bottomNavigationBar;

  /// 다른 날짜로 이동하는 함수
  final Function? moveDate;

  /// 위에 캘린더 모달이 적용된 Scaffold
  CalendarScaffold({
    super.key,
    this.isPatch = false,
    this.addButton = false,
    required this.onTapCalenderVisible,
    required this.isCalendarVisible,
    this.body,
    required this.focusedDay,
    required this.selectedDay,
    this.onPressedAdd,
    required this.updateFocusedDay,
    required this.updateSelectedDate,
    this.bottomNavigationBar,
    this.moveDate,
  });

  @override
  State<CalendarScaffold> createState() => _CalendarScaffoldState();
}

class _CalendarScaffoldState extends State<CalendarScaffold> {
  DateTime? tempSelectedDay;
  DateTime? tempFocusedDay;

  @override
  void initState() {
    super.initState();
    tempSelectedDay = widget.selectedDay;
    tempFocusedDay = widget.focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Palette.gray00,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1.0,
                color: Palette.gray100,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            title: widget.isPatch
                ?

                /// 수정 화면
                Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${widget.selectedDay.month}월 ${widget.selectedDay.day}일',
                        style: const TextStyle(
                          color: Palette.gray900,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                :

                ///등록 화면
                GestureDetector(
                    onTap: () => widget.onTapCalenderVisible!(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          '${widget.selectedDay.month}월 ${widget.selectedDay.day}일',
                          style: const TextStyle(
                            color: Palette.gray900,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Icon(widget.isCalendarVisible
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down),
                      ],
                    ),
                  ),
            centerTitle: true,
            actions: widget.addButton
                ? [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => widget.onPressedAdd!(),
                    ),
                  ]
                : [],
          ),
          backgroundColor: Palette.gray00,
          body: Stack(
            children: [
              // body
              Container(
                child: widget.body,
              ),

              if (widget.isCalendarVisible)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              if (widget.isCalendarVisible)
                AnimatedPositioned(
                  left: 0,
                  right: 0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Palette.gray00,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        TableCalendar(
                          focusedDay: widget.focusedDay,
                          firstDay: DateTime(2000),
                          lastDay: DateTime(2100),
                          daysOfWeekHeight: 30.0,
                          rowHeight: 40,
                          selectedDayPredicate: (day) =>
                              isSameDay(widget.selectedDay, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            if (selectedDay.month == focusedDay.month) {
                              widget.updateFocusedDay!(focusedDay);
                              widget.updateSelectedDate!(selectedDay);
                            }
                          },
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleTextFormatter: (date, locale) {
                              return ('${date.year}년 ${date.month}월');
                            },
                            titleTextStyle: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          calendarStyle: const CalendarStyle(
                            defaultTextStyle: TextStyle(
                              color: Palette.gray300,
                              fontSize: 7,
                            ),
                            weekendTextStyle: TextStyle(
                              color: Palette.gray300,
                              fontSize: 7,
                            ),
                            isTodayHighlighted: false,
                            selectedDecoration: BoxDecoration(
                              color: Palette.green500,
                              shape: BoxShape.circle,
                            ),
                            selectedTextStyle: TextStyle(
                              color: Palette.gray00,
                              fontSize: 7,
                            ),
                            todayDecoration: BoxDecoration(),
                          ),
                          calendarBuilders: CalendarBuilders(
                            dowBuilder: (context, day) {
                              final weekDays = [
                                '월',
                                '화',
                                '수',
                                '목',
                                '금',
                                '토',
                                '일'
                              ];
                              return Center(
                                child: Text(
                                  weekDays[day.weekday - 1],
                                  style: const TextStyle(
                                    fontSize: 8,
                                  ),
                                ),
                              );
                            },
                            outsideBuilder: (context, day, focusedDay) {
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  widget.onTapCalenderVisible!();
                                  widget.updateFocusedDay!(tempFocusedDay);
                                  widget.updateSelectedDate!(tempSelectedDay);
                                },
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
                                onPressed: () {
                                  widget.onTapCalenderVisible!();
                                  widget.updateFocusedDay!(widget.focusedDay);
                                  widget
                                      .updateSelectedDate!(widget.selectedDay);
                                  if (widget.moveDate != null) {
                                    widget.moveDate!();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Palette.green500,
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
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: widget.bottomNavigationBar,
        ),
      ),
    );
  }
}
