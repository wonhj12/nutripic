import 'package:flutter/material.dart';
import 'package:nutripic/objects/diary.dart';
import 'package:nutripic/utils/api.dart';

class DiaryModel with ChangeNotifier {
  // 한달치 다이어리
  List<Diary> diariesForMonth = [];

  //하루치 다이어리
  List<Diary> diariesForDay = [];

  Diary? diary;

  /// 다이어리 데이터 리셋
  void reset() {
    diariesForMonth = [];
    diariesForDay = [];
  }

  /// 한달치 다이어리 가져오기
  Future<void> getDiariesForMonth(int idx) async {
    reset();

    final response = await API.getDiariesForMonth(idx);

    diariesForMonth = response;

    for (var diary in diariesForMonth) {
      debugPrint("Diary: id=${diary.id}, date=${diary.date}, url=${diary.url}");
    }
  }

  /// 하루치 다이어리 가져오기
  Future<void> getDiariesForDay(int idx, int day) async {
    reset();
    final response = await API.getDiariesForDay(idx, day);

    // TODO: 백엔드에서 본문까지 가져오도록 요청
    final List<int> diaryIds =
        response.map<int>((diary) => diary.id as int).toList();
    final List<Future<dynamic>> requests =
        diaryIds.map((id) => API.getDiaryById(id)).toList();
    final diaryresponse = await Future.wait(requests);

    diariesForDay = diaryresponse.map((item) => Diary.fromJson(item)).toList();

    for (var diary in diariesForDay) {
      debugPrint("Diary: id=${diary.id}, date=${diary.date}, url=${diary.url}");
    }
  }

  /// 다이어리 가져오기
  Future<void> getDiary(int diaryId) async {
    final response = await API.getDiaryById(diaryId);

    diary = Diary.fromJson(response);
  }
}
