import 'package:flutter/material.dart';
import 'package:nutripic/components/recipe/recipe_card.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeViewModel recipeViewModel = context.watch<RecipeViewModel>();

    if (recipeViewModel.recipeModel.recipes.isEmpty) {
      //recipeViewModel.updateRecipes();
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true, // Body를 AppBar 뒤로 확장
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 배경 투명
        elevation: 0, // 그림자 제거
        title: const Text(
          "Recipes",
          style: TextStyle(color: Colors.white), // 텍스트 색상 변경 (필요 시)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white), // 아이콘 색상 변경
            onPressed: () {
              recipeViewModel
                  .onTapDetail(recipeViewModel.recipeModel.recipes[0]);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          recipeViewModel.updateRecipes();
        },
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: recipeViewModel.recipeModel.recipes.length,
          itemBuilder: (context, index) {
            return RecipeCard(
                recipe: recipeViewModel.recipeModel.recipes[index]);
          },
        ),
      ),
    );
  }
}
