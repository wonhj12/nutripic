class Food {
  /// 식재료 이름
  final String name;

  /// 식재료 수
  final int count;

  /// 식재료 사진 경로
  final String imageName;

  /// 유통기한
  final DateTime expireDate;

  Food({
    required this.name,
    required this.count,
    required this.imageName,
    required this.expireDate,
  });

  /// 유통기한 마감 d-day를 반환하는 함수
  int dDay() {
    return expireDate.difference(DateTime.now()).inDays;
  }

  @override
  String toString() {
    return 'name: $name, '
        'count: $count, '
        'imageName: $imageName, '
        'expireDate: $expireDate';
  }
}
