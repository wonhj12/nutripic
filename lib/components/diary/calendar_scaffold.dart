import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/common/loading_screen.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScaffold extends StatefulWidget {
  final bool isLoading;
  final bool addButton;
  final bool isPatch;
  DateTime focusedDay;
  DateTime selectedDate;
  final Widget? body;
  final bool isCalendarVisible;
  final String? selectedDateString;
  final Function? onTapCalenderVisible;
  final Function? onPressedAdd;
  final Function? updateFocusedDay;
  final Function? updateSelectedDate;

  /// ### 위에 캘린더 모달이 적용된 Scaffold
  CalendarScaffold({
    super.key,
    this.isLoading = false,
    this.body,
    this.addButton = false,
    this.isPatch = false,
    required this.focusedDay,
    required this.selectedDate,
    required this.isCalendarVisible,
    required this.selectedDateString,
    required this.onTapCalenderVisible,
    this.onPressedAdd,
    required this.updateFocusedDay,
    required this.updateSelectedDate,
  });

  @override
  State<CalendarScaffold> createState() => _CalendarScaffoldState();
}

class _CalendarScaffoldState extends State<CalendarScaffold>
    with SingleTickerProviderStateMixin {
  DateTime? tempSelectedDate;
  DateTime? tempFocusedDay;
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    tempSelectedDate = widget.selectedDate;
    tempFocusedDay = widget.focusedDay;

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInBack));

    if (widget.isCalendarVisible) {
      animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant CalendarScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCalendarVisible != oldWidget.isCalendarVisible) {
      if (widget.isCalendarVisible) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          //나중에 통일해야댐
          backgroundColor: Palette.gray00,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1.0, // 선의 두께
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
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.selectedDateString!,
                      style: const TextStyle(
                        color: Palette.gray900,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () {
                    widget.onTapCalenderVisible!();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.selectedDateString!,
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
                    icon: const Icon(Icons.add), // '추가' 아이콘
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

            // 로딩
            if (widget.isLoading) const Center(child: LoadingScreen()),
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
                child: SlideTransition(
                  position: slideAnimation,
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
                              isSameDay(widget.selectedDate, day),
                          onDaySelected: (selectedDate, focusedDay) {
                            if (selectedDate.month == focusedDay.month) {
                              widget.updateFocusedDay!(focusedDay);
                              widget.updateSelectedDate!(selectedDate);
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
                                  widget.updateFocusedDay!(tempFocusedDay!);
                                  widget.updateSelectedDate!(tempSelectedDate!);
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
                                  widget.updateFocusedDay!(widget.focusedDay!);
                                  widget.updateSelectedDate!(
                                      widget.selectedDate!);
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
              ),
          ],
        ),
      ),
    );
  }
}
