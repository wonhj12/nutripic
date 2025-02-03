import 'package:flutter/material.dart';
import 'package:nutripic/objects/diary.dart';
import 'package:nutripic/utils/api.dart';

class DiaryModel with ChangeNotifier {
  List<Diary> diariesForMonth = [
    // Diary(
    //   diaryId: 1,
    //   date: DateTime(2025, 1, 1),
    //   content: "게시물1",
    //   imageUrl:
    //       "https://i.namu.wiki/i/HDx7Y8WXmam9g0G1AmUfOgV_Jn0CbHC5RjRX1Ccya4eSld6z_fvemYRET4DrKplQaELHgxDaiU9T1sWGz8LCRFksG5FG3mazXs6nLPuYubo125mZiblRODSeV2WB5Mq111hjEAHg_tSXRaDxvLB29A.webp",
    // ),
    // Diary(
    //   diaryId: 2,
    //   date: DateTime(2025, 1, 2),
    //   content: "게시물2",
    //   imageUrl:
    //       "https://i.namu.wiki/i/VXD_sPrS1UvRN-_77YUHxRI0B6NTksSrIaV9bHBRkWUT3IN4ARAvKSOhti-1TtTFB6f7uqVd2ho33ZguUjmyRCCWnFJm8IdlxR8R1jbTOKz7baqApgxWracUIxRSLmJIATvZglVFDMTRZe2yZ6aO3A.webp",
    // ),
    // Diary(
    //   diaryId: 1,
    //   date: DateTime(2025, 1, 25),
    //   content: "게시물1",
    //   imageUrl:
    //       "https://i.namu.wiki/i/HDx7Y8WXmam9g0G1AmUfOgV_Jn0CbHC5RjRX1Ccya4eSld6z_fvemYRET4DrKplQaELHgxDaiU9T1sWGz8LCRFksG5FG3mazXs6nLPuYubo125mZiblRODSeV2WB5Mq111hjEAHg_tSXRaDxvLB29A.webp",
    // ),
    // Diary(
    //   diaryId: 2,
    //   date: DateTime(2025, 1, 25),
    //   content: "게시물2",
    //   imageUrl:
    //       "https://i.namu.wiki/i/VXD_sPrS1UvRN-_77YUHxRI0B6NTksSrIaV9bHBRkWUT3IN4ARAvKSOhti-1TtTFB6f7uqVd2ho33ZguUjmyRCCWnFJm8IdlxR8R1jbTOKz7baqApgxWracUIxRSLmJIATvZglVFDMTRZe2yZ6aO3A.webp",
    // ),
  ];
  List<Diary> diariesForDay = [];
  Diary? diary;

  /// 선택된 다이어리 데이터 리셋
  void reset() {
    diariesForMonth = [];
    diariesForDay = [];
  }

  /// 한달치 다이어리 로딩
  Future<void> getDiariesForMonth(int idx) async {
    reset();
    final response = await API.getDiariesForMonth(idx);
    //print(response.data);
    final List<dynamic> data = response.data;

    diariesForMonth = data.map((item) => Diary.fromJson(item)).toList();

    for (var diary in diariesForMonth) {
      debugPrint(
          "Diary: id=${diary.diaryId}, date=${diary.date}, url=${diary.imageUrl}");
    }
  }

  /// 하루치 다이어리 로딩
  Future<void> getDiariesForDay(int idx, int day) async {
    reset();
    final response = await API.getDiariesForDay(idx, day);
    print(response.data);
    final List<dynamic> data = response.data;

    diariesForDay = data.map((item) => Diary.fromJson(item)).toList();

    for (var diary in diariesForDay) {
      debugPrint(
          "Diary: id=${diary.diaryId}, date=${diary.date}, url=${diary.imageUrl}");
    }
  }
}
