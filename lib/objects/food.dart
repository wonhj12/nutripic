class Food {
  /// 식재료 id
  final int id;

  /// 식재료 이름
  final String name;

  /// 아이콘 이름
  final String icon;

  /// 대분류
  final String class1;

  /// 소분류
  final String class2;

  /// 식재료가 추가된 날짜
  final DateTime addedDate;

  /// 유통기한
  final DateTime? expireDate;

  /// 유통기한 지났는지 여부
  final bool expired;

  /// 유통기한까지 남은 날짜 수
  final int? daysTilExpire;

  Food({
    required this.id,
    required this.name,
    required this.icon,
    required this.class1,
    required this.class2,
    required this.addedDate,
    this.expireDate,
    required this.expired,
    this.daysTilExpire,
  });

  /// jsonData에서 받아온 데이터를 Food로 변환 저장하는 함수
  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'] ?? -1,
      name: json['name'],
      icon: json['icon'] ?? 'carrot',
      class1: json['class1'],
      class2: json['class2'],
      addedDate: DateTime.parse(json['addedDate']),
      expireDate: DateTime.parse(json['expireDate']),
      daysTilExpire: json['daysTilExpire'],
      expired: json['expireDate'] != null && json['daysTilExpire'] != null
          ? DateTime.now()
                  .difference(DateTime.parse(json['expireDate']))
                  .inDays >=
              json['daysTilExpire']
          : false,
    );
  }

  /// Food를 json으로 변환하는 함수
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'class1': class1,
      'class2': class2,
      'addedDate': addedDate.toIso8601String(),
      'expireDate': expireDate?.toIso8601String(),
      // 'daysTilExpire': daysTilExpire,
    };
  }

  @override
  String toString() {
    return 'name: $name, '
        'expireDate: $expireDate';
  }
}
