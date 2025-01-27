class Diary {
  /// 게시물 아이디
  int? diaryId;

  /// 게시 날짜
  DateTime? date;

  /// 게시물 본문
  String? content;

  /// 게시물 사진 Url
  String? imageUrl;

  Diary({
    this.date,
    this.diaryId,
    this.content,
    this.imageUrl,
  });

  /// jsonData에서 받아온 데이터를 Diary로 변환 저장하는 함수
  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      diaryId: json['id'],
      content: json['body'],
      imageUrl: json['url'],
      date: DateTime.parse(json['date']),
    );
  }

  @override
  String toString() {
    return 'diaryId: $diaryId '
        'date: $date '
        'content: $content '
        'imageUrl: $imageUrl';
  }
}
