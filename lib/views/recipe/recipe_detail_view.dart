import 'package:flutter/material.dart';
import 'package:nutripic/components/recipe/recipe_step_item.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/view_models/recipe/recipe_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:nutripic/components/recipe/recipe_info.dart';
import 'package:nutripic/components/recipe/ingredient_item.dart';

class RecipeDetailView extends StatelessWidget {
  const RecipeDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    RecipeDetailViewModel recipeDetailViewModel =
        context.watch<RecipeDetailViewModel>();

    Recipe? recipe = recipeDetailViewModel.recipeModel.specificRecipe;

    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('오류'),
        ),
        body: const Center(
          child: Text(
            '지정된 레시피가 없습니다.',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 232,
            pinned: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 레시피 정보
                  RecipeInfo(recipe: recipe),
                  const SizedBox(height: 24),
                  // 재료 섹션
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * (343 / 375),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 0.7),
                      color: Colors.white, // 투명한 흰색 배경
                      borderRadius: BorderRadius.circular(16), // 모서리 둥글게
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "재료",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Divider(
                          thickness: 0.7,
                          color: Colors.black26,
                        ),
                        const SizedBox(height: 8),
                        // 재료 리스트 (두 개씩)
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: recipe.ingredient
                              .map((ingredient) =>
                                  IngredientItem(ingredient: ingredient))
                              .toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 57),
                  // 조리 단계 섹션

////////////////////////////////////
                  const SizedBox(height: 8),
                  // 조리 단계 리스트
                  Column(
                    children: List.generate(recipe.procedure.length, (index) {
                      return RecipeStepItem(
                        stepNumber: index + 1,
                        stepDescription: recipe.procedure[index],
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  // 레시피 완료 버튼
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // 레시피 완료 시 처리 (예: SnackBar 표시)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('레시피를 완료했습니다!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        '레시피 완료',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
