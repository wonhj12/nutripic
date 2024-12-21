import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

class RecipeViewModel with ChangeNotifier {
  RecipeModel recipeModel;
  BuildContext context;
  RecipeViewModel({
    required this.recipeModel,
    required this.context,
  }) {
    updateRecipes();
  }

  /// 레시피 상세 페이지로 이동
  void onTapDetail(Recipe recipe) {
    recipeModel.saveSpecificRecipe(recipe);
    context.go('/recipe/detail');
  }

  void onTapAll() {
    recipeModel.saveSpecificRecipe(Recipe(
        difficulty: 1,
        recipeName: 'qwer',
        minTime: 1,
        maxTime: 2,
        imageSource: 'asdf'));
    context.go('/recipe/detail');
  }

  /// 레시피 전달하는 것.
  void updateRecipes() {
    final random = Random();
    final Set<int> indices = {};

    while (indices.length < 4) {
      indices.add(random.nextInt(recipeList.length));
    }
    List<Recipe> recipes = indices.map((index) => recipeList[index]).toList();
    recipeModel.saveRecipes(recipes);
    notifyListeners();
  }

  // 필터를 토글하는 메서드
  void toggleFilter(String filter) {
    if (_selectedFilters.contains(filter)) {
      _selectedFilters.remove(filter);
    } else {
      _selectedFilters.add(filter);
    }
    notifyListeners(); // 상태 변경 알림
  }

// 즐겨찾기 상태를 토글하는 메서드
  void toggleFavorite(Recipe recipe) {
    int index = recipeModel.recipes.indexOf(recipe);
    if (index != -1) {
      bool? currentFavorite = recipeModel.recipes[index].isFavorite;
      print("Toggling favorite for ${recipe.recipeName}: $currentFavorite");

      // `currentFavorite`이 null인지 확인
      recipeModel.recipes[index].isFavorite = !currentFavorite;
      print("New favorite state: ${recipeModel.recipes[index].isFavorite}");

      notifyListeners();
    }
  }

// 다이얼로그 표시 메서드
  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('필터에서 삭제할 음식을 선택하세요'),
          content: SingleChildScrollView(
            child: Column(
              children: _foodFilters.map((filter) {
                return CheckboxListTile(
                  title: Text(filter),
                  value: _selectedFilters.contains(filter),
                  onChanged: (bool? value) {
                    toggleFilter(filter);
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                applyFilters(context);
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void applyFilters(BuildContext context) {
    print('적용된 필터: $_selectedFilters');
    Navigator.of(context).pop(); // 다이얼로그 닫기
    notifyListeners(); // 필터 적용 상태를 알림
  }
}

/// 더미 데이터
List<Recipe> recipeList = [
  Recipe(
      recipeName: "연어 계란 샐러드",
      difficulty: 2,
      minTime: 10,
      maxTime: 15,
      imageSource: 'assets/foods/salmon_egg_salad.png'),
  Recipe(
      recipeName: "단호박죽",
      difficulty: 3,
      minTime: 30,
      maxTime: 40,
      imageSource: 'assets/foods/pumpkin_soup.png'),
  Recipe(
      recipeName: "토마토 샐러드",
      difficulty: 1,
      minTime: 10,
      maxTime: 15,
      imageSource: 'assets/foods/tomato_salad.png'),
  Recipe(
      recipeName: "치즈 피자",
      difficulty: 2,
      minTime: 25,
      maxTime: 30,
      imageSource: 'assets/foods/cheese_pizza.png'),
  Recipe(
      recipeName: "페퍼로니 피자",
      difficulty: 3,
      minTime: 25,
      maxTime: 50,
      imageSource: 'assets/foods/pepperoni_pizza.png'),
  Recipe(
      recipeName: "하와이안 피자",
      difficulty: 2,
      minTime: 5,
      maxTime: 30,
      imageSource: 'assets/foods/hawaiian_pizza.png'),
  Recipe(
      recipeName: "고르곤졸라 피자",
      difficulty: 1,
      minTime: 25,
      maxTime: 35,
      imageSource: 'assets/foods/gorgonzola_pizza.png'),
  Recipe(
      recipeName: "불닭볶음면",
      difficulty: 1,
      minTime: 5,
      maxTime: 10,
      imageSource: 'assets/foods/buldak_noodle.png'),
];

List<String> _foodFilters = [
  'Carrot',
  'Egg',
  'Lettuce',
  'Tomato',
  'chicken',
  'grape',
  'potato',
];
final List<String> _selectedFilters = []; // 선택된 필터 저장
