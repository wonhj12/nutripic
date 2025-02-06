import 'package:flutter/material.dart';
import 'package:nutripic/objects/diary.dart';
import 'package:nutripic/utils/api.dart';

class DiaryModel with ChangeNotifier {
  // 한달치 다이어리
  List<Diary> diariesForMonth = [];

  //하루치 다이어리
  List<Diary> diariesForDay = [
    Diary(
      diaryId: 1,
      content: "크게될 친구",
      date: DateTime(2025, 2, 3, 5, 12),
      imageUrl:
          "https://i.namu.wiki/i/kKfynGpkO0JAORFLsu0FHZ7TkIkpYeelP3sokPrfVGXR7iUtfcZZUplyr-Lb8w9ttfgYpNKM0PS-wEmaWZa_C8dmQQw0xDbZJC-m9G-Ip5tuhCIpgSE47nP5NLWHtS_eSFGq0mM4V_oI8PW1hEPggg.webp",
    )
  ];

  Diary? diary;

  /// 선택된 다이어리 데이터 리셋
  void reset() {
    diariesForMonth = [];
    //diariesForDay = [];
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
    //print(response.data);
    final List<dynamic> data = response.data;

    diariesForDay = data.map((item) => Diary.fromJson(item)).toList();

    for (var diary in diariesForDay) {
      debugPrint(
          "Diary: id=${diary.diaryId}, date=${diary.date}, url=${diary.imageUrl}");
    }
  }
}
