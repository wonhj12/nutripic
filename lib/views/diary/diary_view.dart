import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

    return CustomScaffold(
      appBar: const CustomAppBar(backButton: false),
      body: Column(
        children: [
          //커스텀 헤더
          Row(
            children: [
              //왼쪽 버튼 (이전 달 이동)
              GestureDetector(
                onTap: diaryViewModel.goToPreviousMonth,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                '${diaryViewModel.focusedDay.month}월',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //오른쪽 버튼 (다음 달 이동)
              GestureDetector(
                onTap: diaryViewModel.goToNextMonth,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          //한 달 요약
          Container(
            width: double.infinity,
            height: 96,
            margin: const EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFDAFFF1)),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                //그래프
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // 원형 그래프
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: CircularProgressIndicator(
                        value: diaryViewModel.getProperMealPercentage(),
                        strokeCap: StrokeCap.round,
                        strokeWidth: 10,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF1A9F6E),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                      crossAxisAlignment: CrossAxisAlignment.baseline, // 기준선 정렬
                      textBaseline: TextBaseline.alphabetic, // 텍스트 기준선
                      children: [
                        Text(
                          (diaryViewModel.getProperMealPercentage() * 100)
                              .toStringAsFixed(1), // 큰 텍스트
                          style: const TextStyle(
                            color: Color(0xFF1A9F6E),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "%", // 작은 텍스트
                          style: TextStyle(
                            color: Color(0xFF1A9F6E),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),

                //글씨
                Text(
                  '${diaryViewModel.getTotalDaysInMonth()}일 중 ${diaryViewModel.getDiariesForMonth()}일을\n건강하게 식사했습니다!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          //실제 캘린더
          Expanded(
            child: TableCalendar(
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
                diaryViewModel.updateFocusedDay(
                    focusedDay); // 페이지 변경 시에만 _focusedDay 업데이트
              },
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
          ),
        ],
      ),

      //게시글 추가버튼
      floatingActionButton: Stack(
        children: [
          if (diaryViewModel.clicked)
            //TODO 화면 회색 블러 처리
            GestureDetector(
              onTap: diaryViewModel.floatingButtonClick,
            ),

          //카메라 선택 버튼
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: diaryViewModel.clicked ? 65 : 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: diaryViewModel.clicked ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                heroTag: "cameraTag",
                shape: const CircleBorder(),
                onPressed: () {
                  diaryViewModel.imagePick(ImageSource.camera);
                },
                backgroundColor: Colors.grey,
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),

          //갤러리 선택 버튼
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: diaryViewModel.clicked ? 130 : 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: diaryViewModel.clicked ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                heroTag: "galleryTag",
                shape: const CircleBorder(),
                onPressed: () => diaryViewModel.imagePick(ImageSource.gallery),
                backgroundColor: Colors.grey,
                child: const Icon(Icons.photo),
              ),
            ),
          ),

          //선택버튼
          Positioned(
            bottom: 0,
            right: 0,
            child: FloatingActionButton(
              heroTag: "mainTag",
              backgroundColor: const Color(0xFF1FD893),
              shape: const CircleBorder(),
              onPressed: diaryViewModel.floatingButtonClick,
              child: Icon(diaryViewModel.clicked ? Icons.close : Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
