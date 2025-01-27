import 'package:flutter/material.dart';
import 'package:nutripic/objects/diary.dart';
import 'package:nutripic/utils/api.dart';

class DiaryModel with ChangeNotifier {
  List<Diary> diariesForMonth = [
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
  Diary? diary;

  /// 선택된 다이어리 데이터 리셋
  void reset() {
    diariesForMonth = [];
  }

  /// 한달치 다이어리 로딩
  Future<void> getDiaries(int idx) async {
    // reset();
    // final response = await API.getDiariesForMonth(idx);
    // //print(response.data);
    // final List<dynamic> data = response.data;

    // diariesForMonth = data.map((item) => Diary.fromJson(item)).toList();

    // for (var diary in diariesForMonth) {
    //   debugPrint(
    //       "Diary: id=${diary.diaryId}, date=${diary.date}, url=${diary.imageUrl}");
    // }
  }
}
