import 'package:nutripic/objects/ingredient.dart';

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

  // 즐겨찾기 여부
  bool isFavorite;

  // 레시피 순서
  List<String> steps;

  // 재료
  List<Ingredient> ingredients;

  Recipe({
    required this.recipeName,
    required this.difficulty,
    required this.minTime,
    required this.maxTime,
    required this.imageSource,
    this.isFavorite = false,
    this.steps = const [],
    this.ingredients = const [],
  });

  @override
  String toString() {
    return 'recipeName: $recipeName, '
        'difficulty: $difficulty, '
        'minTime: $minTime, '
        'maxTime: $maxTime';
  }
}
