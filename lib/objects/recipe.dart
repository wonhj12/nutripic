class Recipe {
  /// 레시피 이름
  final String recipeName;

  /// 난이도
  final int difficulty;

  /// 최소 시간
  final int minTime;

  /// 최대 시간
  final int maxTime;

  // 이미지 소스
  final String imageSource;

  Recipe({
    required this.recipeName,
    required this.difficulty,
    required this.minTime,
    required this.maxTime,
    required this.imageSource,
  });

  @override
  String toString() {
    return 'recipeName: $recipeName, '
        'difficulty: $difficulty, '
        'minTime: $minTime, '
        'maxTime: $maxTime';
  }
}
