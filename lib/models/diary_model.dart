import 'package:flutter/material.dart';

class DiaryModel with ChangeNotifier {
  //게시 날짜
  DateTime? date;

  //게시글 아이디
  String? diaryId;

  //본문
  String? content;

  //게시물 사진 url
  //String? imageUrl;

  DiaryModel({
    this.date,
    this.diaryId,
    this.content,
    //this.imageURl,
  });

  @override
  String toString() {
    return 'diaryId: $diaryId,'
        'content: $content,';
  }
}


/*
{
  "2023-10-01": [
    {
      "identifier": "1",
      "title": "Event 1",
      "imageUrl": "https://example.com/img1.jpg"
    },
    {
      "identifier": "2",
      "title": "Event 2",
      "imageUrl": "https://example.com/img2.jpg"
    }
  ],
  "2023-10-02": [
    {
      "identifier": "3",
      "title": "Event 3",
      "imageUrl": "https://example.com/img3.jpg"
    }
  ]
}
{
  DateTime(2023, 10, 1): [
    Diary(identifier: '1', title: 'Event 1', imageUrl: 'https://example.com/img1.jpg'),
    Diary(identifier: '2', title: 'Event 2', imageUrl: 'https://example.com/img2.jpg'),
  ],
  DateTime(2023, 10, 2): [
    Diary(identifier: '3', title: 'Event 3', imageUrl: 'https://example.com/img3.jpg'),
  ]
}*/