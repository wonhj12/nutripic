import 'package:nutripic/objects/ingredient.dart';

class Recipe {
  // 아이디
  final int id;

  /// 레시피 이름
  final String name;

  /// 난이도
  final int difficulty;

  /// 소요 시간
  final int cookingTime;

  // 이미지 소스
  final String imageUrl;

  // 즐겨찾기 여부
  bool isFavorite;

  // 레시피 순서
  List<String> procedure;

  // 재료
  List<Ingredient> ingredient;

  Recipe({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.cookingTime,
    this.imageUrl = 'assets/foods/cheese_pizza.png',
    this.isFavorite = false,
    this.procedure = const [],
    this.ingredient = const [],
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredients = (json['ingredient'] as List)
        .map((json) => Ingredient.fromJson(json))
        .toList();
    List<String> procedures =
        (json['procedure'] as List).map((e) => e.toString()).toList();
    return Recipe(
      id: json['id'],
      name: json['name'],
      difficulty: json['difficulty'],
      cookingTime: json['cookingTime'],
      imageUrl: json['imageUrl'],
      ingredient: ingredients,
      procedure: procedures,
    );
  }
}
