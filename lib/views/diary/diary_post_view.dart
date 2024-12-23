import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/diary/diary_post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryPostView extends StatefulWidget {
  const DiaryPostView({super.key});

  @override
  State<DiaryPostView> createState() => _DiaryPostViewState();
}

class _DiaryPostViewState extends State<DiaryPostView> {
  @override
  Widget build(BuildContext context) {
    DiaryPostViewModel diaryPostViewModel = context.watch<DiaryPostViewModel>();

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
          onTap: () => diaryPostViewModel.onTapCalenderVisible(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 15,
              ),
              Text(
                diaryPostViewModel.selectedDateString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Icon(diaryPostViewModel.isCalendarVisible
                  ? Icons.arrow_drop_up
                  : Icons.arrow_drop_down),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // 사진
                  diaryPostViewModel.imageUrl == null
                      ? GestureDetector(
                          onTap: () => diaryPostViewModel.selectFromAlbum(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Palette
                                  .gray100, // Background color of the container
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Palette.gray150,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(
                                    Icons.photo_library_outlined,
                                    size: 40,
                                    color: Palette.black,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  "이미지 업로드",
                                  style: Palette.caption,
                                ),
                              ],
                            ),
                          ))
                      : Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(diaryPostViewModel.imageUrl!),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover, // 이미지를 컨테이너에 맞춤
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Palette.gray100.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: IconButton(
                                  onPressed: () =>
                                      diaryPostViewModel.selectFromAlbum(),
                                  icon:
                                      const Icon(Icons.photo_library_outlined),
                                  iconSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 20),
                  // 시간 선택
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: DiaryPostViewModel.diary_time.map((time) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: GestureDetector(
                          onTap: () {
                            diaryPostViewModel.selectTime(time);
                          },
                          child: Container(
                            height: 35,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: diaryPostViewModel.isSelected(time)
                                  ? Palette.primary
                                  : Colors.transparent, // 선택된 버튼 색상
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: diaryPostViewModel.isSelected(time)
                                    ? Palette.primary
                                    : Palette.gray300, // 테두리 색상
                                width: 1,
                              ),
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                color: diaryPostViewModel.isSelected(time)
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // 게시글
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Palette.gray100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.width -
                            300, // 남은 화면 크기 계산
                      ),
                      child: TextFormField(
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: '메모하기',
                          hintStyle: TextStyle(color: Palette.gray300),
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                          filled: true,
                        ),
                        style: Palette.caption, // Text color inside the field
                        textInputAction: TextInputAction.done,
                        onChanged: (text) {
                          diaryPostViewModel.updateInputText(text); // 입력값 동기화
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // 게시 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: diaryPostViewModel.isPostable
                          ? () {
                              diaryPostViewModel.submitPost(context);
                              context.go('/diary');
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Palette.primary,
                        disabledBackgroundColor: Palette.gray100,
                      ),
                      child: Text(
                        '등록',
                        style: TextStyle(
                          fontSize: 8,
                          color: diaryPostViewModel.isPostable
                              ? Colors.white // 활성화된 색상
                              : Palette.gray400,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (diaryPostViewModel.isCalendarVisible)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.8),
              ),
            ),
          if (diaryPostViewModel.isCalendarVisible)
            Positioned(
              top: 0, // 캘린더를 최상단에서 시작
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 350,
                decoration: const BoxDecoration(
                  color: Palette.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    TableCalendar(
                      focusedDay: diaryPostViewModel.focusedDay,
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2100),
                      daysOfWeekHeight: 30.0,
                      rowHeight: 40,
                      selectedDayPredicate: (day) =>
                          isSameDay(diaryPostViewModel.selectedDate, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        if (selectedDay.month ==
                            diaryPostViewModel.focusedDay.month) {
                          diaryPostViewModel.selectedDate = selectedDay;
                          diaryPostViewModel.updateFocusedDay(focusedDay);
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
                        defaultTextStyle: Palette.caption,
                        weekendTextStyle: Palette.caption,
                        isTodayHighlighted: false,
                        selectedDecoration: BoxDecoration(
                          color: Palette.primary,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: Palette.caption,
                        todayDecoration: BoxDecoration(),
                      ),
                      calendarBuilders: CalendarBuilders(
                        dowBuilder: (context, day) {
                          final weekDays = ['월', '화', '수', '목', '금', '토', '일'];
                          return Center(
                            child: Text(
                              weekDays[
                                  day.weekday - 1], // day.weekday - 1로 요일 배열 접근
                              style: Palette.caption,
                            ),
                          );
                        },
                        outsideBuilder: (context, day, focusedDay) {
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () =>
                              diaryPostViewModel.onTapCalenderVisible(),
                          child: const Text(
                            "확인",
                            style: Palette.caption,
                          ),
                        )
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
