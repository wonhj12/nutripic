import 'package:flutter/material.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

import 'package:nutripic/utils/api.dart';

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
  void onTapDetail(Recipe recipe) async {
    try {
      recipeModel.saveSpecificRecipe(recipe);
      context.go('/recipe/detail');
    } catch (e) {
      debugPrint('$e');
    }
  }

  void onTapAll() {
    recipeModel.saveSpecificRecipe(Recipe(
        id: 3, difficulty: 1, name: 'qwer', cookingTime: 2, imageUrl: 'asdf'));
    context.go('/recipe/detail');
  }

  void onRecipeSearch() {
    context.go('/recipe/search');
  }

  /// 레시피 전달하는 것.
  void updateRecipes() async {
    try {
      final List<int> recipeIds = [];

      final reconmmendedRecipes = await API.getRecipes();
      if (reconmmendedRecipes != null) {
        if (reconmmendedRecipes[0].length == 0 &&
            reconmmendedRecipes[1].length == 0) {
          final random = Random();
          final Set<int> indices = {};

          while (indices.length < 10) {
            // 무한 루프 방지
            indices.add(random.nextInt(30));
          }
          recipeIds.addAll(indices.toList());
        } else {
          final random = Random();
          final Set<int> indices = {};

          while (indices.length < 10) {
            // 무한 루프 방지
            indices.add(random.nextInt(22));
          }
          recipeIds.addAll(indices.toList());
        }
        final List<Recipe> recipes = await API.recipePreview(recipeIds);
        recipeModel.saveRecipes(recipes);
        notifyListeners();
        return;
      } else {
        return;
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('StackTrace: $stackTrace');
    }
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
      debugPrint('Toggling favorite for ${recipe.name}: $currentFavorite');

      // `currentFavorite`이 null인지 확인
      recipeModel.recipes[index].isFavorite = !currentFavorite;
      debugPrint(
          'New favorite state: ${recipeModel.recipes[index].isFavorite}');

      notifyListeners();
    }
  }

// 필터 화면 이동
  void onFilter() {
    context.go('/recipe/search/filter');
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
    debugPrint('적용된 필터: $_selectedFilters');
    Navigator.of(context).pop(); // 다이얼로그 닫기
    notifyListeners(); // 필터 적용 상태를 알림
  }
}

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

