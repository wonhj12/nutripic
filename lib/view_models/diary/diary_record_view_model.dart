import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/models/diary_model.dart';
import 'package:nutripic/objects/diary.dart';
import 'package:nutripic/utils/api.dart';
import 'package:nutripic/utils/palette.dart';

class DiaryRecordViewModel extends ChangeNotifier {
  DiaryModel diaryModel;
  BuildContext context;
  DateTime selectedDate;
  DateTime focusedDay = DateTime.now();
  bool isLoading = false;
  bool isCalendarVisible = false;

  DiaryRecordViewModel({
    required this.diaryModel,
    required this.context,
    required this.selectedDate,
  });

  List<Diary> todayDiaries = [
    Diary(
      diaryId: 1,
      date: DateTime(2025, 1, 25),
      content: "게시물1",
      imageUrl:
          "https://m.363sg.co.kr/web/product/medium/202008/2b96908838fe5b610b0b31c7fb752b47.jpg",
    ),
    Diary(
      diaryId: 2,
      date: DateTime(2025, 1, 24),
      content: "게시물2",
      imageUrl:
          "https://m.363sg.co.kr/web/product/medium/202008/0b564c2db19eb7f7b363beab3a505add.jpg",
    ),
  ];

  /// 캘린더 표시 함수
  void onTapCalenderVisible() async {
    isCalendarVisible = !isCalendarVisible;
    notifyListeners();
  }

  ///게시글 추가 화면으로 이동
  void navigateToDiaryPost() {
    context.go('/diary/post', extra: selectedDate);
  }

  ///선택 날짜 변경 함수
  void updateFocusedDay(DateTime newFocusedDay) {
    focusedDay = newFocusedDay;
    notifyListeners();
  }

  String selectedDateString() {
    return '${selectedDate.month}월 ${selectedDate.day}일';
  }

  static String getTime(DateTime time) {
    return '${time.hour}시 ${time.minute}분';
  }

  Future<void> getDiaryRecord() async {
    isLoading = true;
    // 서버에서 각 날짜별로 달라고 해야겠다...
    final response =
        await API.getDiariesForMonth(DateTime.now().month - selectedDate.month);
    final List<dynamic> data = response.data;
    final List<Diary> diariesForMonth =
        data.map((item) => Diary.fromJson(item)).toList();

    final List<int?> diaryIdsForSelectedDate = diariesForMonth
        .where((diary) =>
            diary.date?.year == selectedDate.year &&
            diary.date?.month == selectedDate.month &&
            diary.date?.day == selectedDate.day)
        .map((diary) => diary.diaryId)
        .toList();

    for (final id in diaryIdsForSelectedDate) {
      if (id == null) continue; // ID가 null인 경우 건너뜀

      try {
        final diaryResponse = await API.getDiariesForDay(id);
        final Diary diary = Diary.fromJson(diaryResponse.data);
        if (!todayDiaries
            .any((existingDiary) => existingDiary.diaryId == diary.diaryId)) {
          todayDiaries.add(diary);
          debugPrint('DiaryToday added: ${diary.diaryId}, ${diary.content}');
          debugPrint('Diary Details for ID $id: ${diaryResponse.data}');
        }
      } catch (e) {
        debugPrint('Error fetching diary with ID $id: $e');
      }
    }

    notifyListeners();
  }

  Future<void> deleteDiaryRecord(int diaryId) async {
    await deleteDiaryRecord(diaryId);
    await getDiaryRecord();
    debugPrint('Diary with ID $diaryId has been removed.');
  }

  // TODO : 모달 컴포넌트 별도로 만들어서 뷰모델과 분리
  void showOptionModal(int diaryId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Palette.gray100.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 내용에 맞게 높이 조정
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    //deleteDiaryRecord(diaryId);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.edit),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "수정은 나중에 만들어볼게요...",
                        style: Palette.caption,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1, // 선의 두께
                  color: Palette.gray100.withOpacity(0.7), // 선 색상
                  // 끝 위치 들여쓰기
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    //deleteDiaryRecord(diaryId);
                    Navigator.pop(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(Icons.delete_outline),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "삭제",
                        style: Palette.caption,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }
}
