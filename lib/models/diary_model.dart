import 'package:flutter/material.dart';
import 'package:nutripic/objects/diary.dart';

class DiaryModel with ChangeNotifier {
  // List<Diary> diaries = [];
  Diary? diary;

  /// 선택된 다이어리 데이터 리셋
  void reset() {
    diary = null;
  }

  // 임시 dummy data
  List<Diary> diaries = [
    Diary(
        diaryId: '1',
        content: '일',
        date: DateTime.utc(2024, 10, 17),
        imageUrl:
            "https://i.namu.wiki/i/CleVBJm82x9kSemYpj3UNakAVGDvBwil3TvKYwGV6JrvdyfQCqf-OswyWnbiOJnK8I9vKx_yKTvbWRqMK9lYTavFrE0Sl-wQh3O1v5WQPpxEgyoxsvd5dBUJ4HVsT2O9ojzv5fV__bzTVkzXvyMImQ.webp"),
    Diary(
        diaryId: '11',
        content: '일-일',
        date: DateTime.utc(2024, 10, 17),
        imageUrl:
            "https://i.namu.wiki/i/jtaZQZSk015LRK6aJF_V8BMR4dAWzDqZgekwgpo_Sm4_BIb0Abx-0el28VJDE2zcaMmW2ACTI_VACZdTdhKbkw.webp"),
    Diary(
        diaryId: '2-2',
        content: '이',
        date: DateTime.utc(2024, 10, 22),
        imageUrl:
            "https://i.namu.wiki/i/yJ-oCRQx8_a7VcJK4aNVlbbBUQqyd0jcvRFD3x5n-WQ7AmzA4bTUkfjShdhJvSRh8cP9qS2h0-IynU3y5aWapw.webp"),
    Diary(
        diaryId: '2',
        content: '이-이',
        date: DateTime.utc(2024, 10, 22),
        imageUrl:
            "https://i.namu.wiki/i/-Qye3uCOyJllzK9PTjZe-q_-OpNTUCLmYWgXG67-qVppqW2lVxQld57HvAavAf7Qd4eIr5c_13fus0JbFU3w6CIIcl9V4hnX8upRbCw3SFWCIiUqWO126LpUo8_PZRGN-vx4prSOfOo1EzisakmJog.webp"),
    Diary(
        diaryId: '3',
        content: '삼',
        date: DateTime.utc(2024, 10, 24),
        imageUrl:
            "https://i.namu.wiki/i/oEhcG4nVgvOL9QxY-EZzWAgCNbrV_LXhbT-cKwMo9ofQjCDjyQTNox5QN3dvQWvVGzbyXH93VwgcceF7D7pCekvrUgX6lXBktYSiXqPMAxJM1RYczKcnFCp5CeyI2iE7q-j2GSzhXRk5wRgzMtVN_A.webp"),
  ];
}
