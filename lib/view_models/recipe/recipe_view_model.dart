import 'package:flutter/material.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:go_router/go_router.dart';
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
  void onTapDetail(int idx) async {
    try {
      recipeModel.selectedRecipe = recipeModel.recipes[idx];
      context.go('/recipe/detail');
    } catch (e) {
      debugPrint('$e');
    }
  }

  void onRecipeSearch() {
    context.go('/recipe/search');
  }

  /// 레시피 전달하는 것.
  void updateRecipes() async {
    try {
      final recipeIds = await API.getRecipes();
      final List<Recipe> recipes = await API.recipePreview(recipeIds);
      recipeModel.saveRecipes(recipes);
      notifyListeners();
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
  void toggleFavorite(int index) async {
    try {
      if (recipeModel.recipes[index].isFavorite) {
        recipeModel.recipes[index].isFavorite = false;
        await API.deleteRecipeBookmark(recipeModel.recipes[index].id);
      } else {
        recipeModel.recipes[index].isFavorite = true;
        await API.postRecipeBookmarkAdd(recipeModel.recipes[index].id);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error in toggleFavorite: $e');
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
