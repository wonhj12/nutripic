import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:nutripic/models/recipe_model.dart';
import 'package:nutripic/objects/ingredient.dart';
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
      dynamic specificRecipe = await API.getSpecificRecipes(recipe.id);

      List<Ingredient> Ingredients = (specificRecipe['ingredient'] as List)
          .map((json) => Ingredient.fromJson(json))
          .toList();
      recipe.ingredient = Ingredients;
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
          //recipeIds.addAll(reconmmendedRecipes[0]);
          //recipeIds.addAll(reconmmendedRecipes[1]);
          final random = Random();
          final Set<int> indices = {};

          while (indices.length < 5) {
            // 무한 루프 방지
            indices.add(random.nextInt(10));
          }
          recipeIds.addAll(indices.toList());
        }
        print(recipeIds);
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
      print("Toggling favorite for ${recipe.name}: $currentFavorite");

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

/*
/// 더미 데이터
List<Recipe> recipeList = [
  Recipe(
    id: 1,
    name: "연어 계란 샐러드",
    difficulty: 2,
    cookingTime: 15,
    imageSource: 'assets/foods/salmon_egg_salad.png',
    ingredient: [
      Ingredient(name: "연어", quantity: "200g"),
      Ingredient(name: "계란", quantity: "2개"),
      Ingredient(name: "상추", quantity: "1컵"),
      Ingredient(name: "올리브 오일", quantity: "2큰술"),
      Ingredient(name: "소금", quantity: "약간"),
      Ingredient(name: "후추", quantity: "약간"),
    ],
    procedure: [
      "연어를 적당한 크기로 손질합니다.",
      "계란을 삶아 잘게 썰어줍니다.",
      "상추를 깨끗이 씻어 물기를 제거합니다.",
      "볼에 올리브 오일, 소금, 후추를 넣고 드레싱을 만듭니다.",
      "모든 재료를 볼에 넣고 잘 섞어줍니다.",
      "완성된 샐러드를 접시에 담아 제공합니다.",
    ],
  ),
  Recipe(
    id: 2,
    name: "단호박죽",
    difficulty: 3,
    cookingTime: 40,
    imageSource: 'assets/foods/pumpkin_soup.png',
    ingredient: [
      Ingredient(name: "단호박", quantity: "500g"),
      Ingredient(name: "물", quantity: "800ml"),
      Ingredient(name: "설탕", quantity: "2큰술"),
      Ingredient(name: "우유", quantity: "200ml"),
      Ingredient(name: "시나몬 가루", quantity: "약간"),
    ],
    procedure: [
      "단호박을 깨끗이 씻어 껍질을 벗기고 큼직하게 자릅니다.",
      "냄비에 단호박과 물을 넣고 부드러워질 때까지 끓입니다.",
      "단호박을 블렌더나 푸드 프로세서에 넣고 곱게 갈아줍니다.",
      "다시 냄비에 갈아놓은 단호박을 넣고 끓입니다.",
      "설탕과 우유를 추가하여 잘 섞어줍니다.",
      "원한다면 시나몬을 약간 뿌려 마무리합니다.",
    ],
  ),
  Recipe(
    id: 3,
    name: "토마토 샐러드",
    difficulty: 1,
    cookingTime: 15,
    imageSource: 'assets/foods/tomato_salad.png',
    ingredient: [
      Ingredient(name: "토마토", quantity: "3개"),
      Ingredient(name: "오이", quantity: "1개"),
      Ingredient(name: "적양파", quantity: "1/2개"),
      Ingredient(name: "올리브 오일", quantity: "2큰술"),
      Ingredient(name: "식초", quantity: "1큰술"),
      Ingredient(name: "소금", quantity: "약간"),
      Ingredient(name: "후추", quantity: "약간"),
      Ingredient(name: "신선한 바질", quantity: "몇 잎 (선택사항)"),
    ],
    procedure: [
      "토마토와 오이를 깨끗이 씻어 적당한 크기로 자릅니다.",
      "적양파를 얇게 슬라이스합니다.",
      "큰 볼에 토마토, 오이, 양파를 넣습니다.",
      "올리브 오일과 식초를 섞어 드레싱을 만듭니다.",
      "드레싱을 샐러드에 뿌리고 소금, 후추로 간을 맞춥니다.",
      "원한다면 신선한 바질 잎을 추가하여 장식합니다.",
    ],
  ),
  Recipe(
    id: 4,
    name: "치즈 피자",
    difficulty: 2,
    cookingTime: 30,
    imageSource: 'assets/foods/cheese_pizza.png',
    ingredient: [
      Ingredient(name: "피자 도우", quantity: "1개"),
      Ingredient(name: "토마토 소스", quantity: "1/2컵"),
      Ingredient(name: "모짜렐라 치즈", quantity: "200g"),
      Ingredient(name: "파르메산 치즈", quantity: "50g (선택사항)"),
      Ingredient(name: "올리브 오일", quantity: "1큰술"),
      Ingredient(name: "오레가노", quantity: "약간"),
    ],
    procedure: [
      "오븐을 220도로 예열합니다.",
      "피자 도우를 얇게 밀어 원하는 크기로 펴줍니다.",
      "도우 위에 토마토 소스를 고르게 펴 발라줍니다.",
      "모짜렐라 치즈를 듬뿍 올립니다.",
      "파르메산 치즈와 오레가노를 뿌려줍니다.",
      "올리브 오일을 약간 뿌린 후, 예열된 오븐에 넣어 15-20분간 구워줍니다.",
      "오븐에서 꺼내어 식힌 후, 서빙합니다.",
    ],
  ),
  Recipe(
    id: 5,
    name: "페퍼로니 피자",
    difficulty: 3,
    cookingTime: 50,
    imageSource: 'assets/foods/pepperoni_pizza.png',
    ingredient: [
      Ingredient(name: "피자 도우", quantity: "1개"),
      Ingredient(name: "토마토 소스", quantity: "1/2컵"),
      Ingredient(name: "모짜렐라 치즈", quantity: "200g"),
      Ingredient(name: "페퍼로니 슬라이스", quantity: "100g"),
      Ingredient(name: "파르메산 치즈", quantity: "50g (선택사항)"),
      Ingredient(name: "올리브 오일", quantity: "1큰술"),
      Ingredient(name: "오레가노", quantity: "약간"),
    ],
    procedure: [
      "오븐을 220도로 예열합니다.",
      "피자 도우를 얇게 밀어 원하는 크기로 펴줍니다.",
      "도우 위에 토마토 소스를 고르게 펴 발라줍니다.",
      "모짜렐라 치즈를 듬뿍 올립니다.",
      "페퍼로니 슬라이스를 골고루 배치합니다.",
      "파르메산 치즈와 오레가노를 뿌려줍니다.",
      "올리브 오일을 약간 뿌린 후, 예열된 오븐에 넣어 15-20분간 구워줍니다.",
      "오븐에서 꺼내어 식힌 후, 서빙합니다.",
    ],
  ),
  Recipe(
    id: 6,
    name: "하와이안 피자",
    difficulty: 2,
    cookingTime: 30,
    imageSource: 'assets/foods/hawaiian_pizza.png',
    ingredient: [
      Ingredient(name: "피자 도우", quantity: "1개"),
      Ingredient(name: "토마토 소스", quantity: "1/2컵"),
      Ingredient(name: "모짜렐라 치즈", quantity: "200g"),
      Ingredient(name: "햄 슬라이스", quantity: "100g"),
      Ingredient(name: "파인애플 조각", quantity: "100g"),
      Ingredient(name: "올리브 오일", quantity: "1큰술"),
      Ingredient(name: "오레가노", quantity: "약간"),
    ],
    procedure: [
      "오븐을 220도로 예열합니다.",
      "피자 도우를 얇게 밀어 원하는 크기로 펴줍니다.",
      "도우 위에 토마토 소스를 고르게 펴 발라줍니다.",
      "모짜렐라 치즈를 듬뿍 올립니다.",
      "햄 슬라이스와 파인애플 조각을 골고루 배치합니다.",
      "오레가노를 뿌리고, 올리브 오일을 약간 뿌립니다.",
      "예열된 오븐에 넣어 15-20분간 구워줍니다.",
      "오븐에서 꺼내어 식힌 후, 서빙합니다.",
    ],
  ),
  Recipe(
    id: 7,
    name: "고르곤졸라 피자",
    difficulty: 1,
    cookingTime: 35,
    imageSource: 'assets/foods/gorgonzola_pizza.png',
    ingredient: [
      Ingredient(name: "피자 도우", quantity: "1개"),
      Ingredient(name: "고르곤졸라 치즈", quantity: "150g"),
      Ingredient(name: "모짜렐라 치즈", quantity: "100g"),
      Ingredient(name: "호두", quantity: "50g (선택사항)"),
      Ingredient(name: "꿀", quantity: "1큰술 (선택사항)"),
      Ingredient(name: "올리브 오일", quantity: "1큰술"),
      Ingredient(name: "오레가노", quantity: "약간"),
    ],
    procedure: [
      "오븐을 220도로 예열합니다.",
      "피자 도우를 얇게 밀어 원하는 크기로 펴줍니다.",
      "고르곤졸라 치즈와 모짜렐라 치즈를 적당히 섞어 올립니다.",
      "호두를 잘게 부순 후 피자 위에 뿌립니다.",
      "오레가노를 뿌리고, 올리브 오일을 약간 뿌립니다.",
      "예열된 오븐에 넣어 15-20분간 구워줍니다.",
      "오븐에서 꺼내어 꿀을 살짝 뿌린 후, 서빙합니다.",
    ],
  ),
  Recipe(
    id: 8,
    name: "불닭볶음면",
    difficulty: 1,
    cookingTime: 10,
    imageSource: 'assets/foods/buldak_noodle.png',
    ingredient: [
      Ingredient(name: "불닭볶음면", quantity: "1개"),
      Ingredient(name: "물", quantity: "550ml"),
      Ingredient(name: "신선한 파", quantity: "2대 (선택사항)"),
      Ingredient(name: "삶은 계란", quantity: "1개 (선택사항)"),
      Ingredient(name: "치즈", quantity: "1장 (선택사항)"),
    ],
    procedure: [
      "냄비에 물을 끓입니다.",
      "물이 끓으면 불닭볶음면을 넣고 3분간 끓입니다.",
      "면이 익으면 불을 끄고 소스와 스프를 넣어 잘 섞습니다.",
      "원한다면, 슬라이스한 파, 삶은 계란, 치즈 등을 추가하여 즐깁니다.",
      "뜨겁게 데운 상태로 서빙합니다.",
    ],
  ),
];

*/
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

