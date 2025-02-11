class Diary {
  /// 게시물 아이디
  int? id;

  /// 게시 날짜
  DateTime? date;

  /// 게시물 본문
  String? body;

  /// 게시물 사진 Url
  String? url;

  /// 식사시간
  String? mealTime;

  Diary({
    this.id,
    this.body,
    this.url,
    this.date,
    this.mealTime,
  });

  static const Map<int, String> mealTimeMapping = {
    1: '아침',
    2: '점심',
    3: '저녁',
    4: '간식',
    5: '기타',
  };

  /// jsonData에서 받아온 데이터를 Diary로 변환 저장하는 함수
  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
        id: json['id'],
        body: json['body'],
        url: json['url'],
        date: DateTime.parse(json['date']),
        mealTime: mealTimeMapping[json['mealTime']]);
  }

  @override
  String toString() {
    return 'diaryId: $id '
        'date: $date '
        'content: $body '
        'imageUrl: $url';
  }
}
