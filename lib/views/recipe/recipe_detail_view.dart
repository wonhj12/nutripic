import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/components/common/main_button.dart';
import 'package:nutripic/components/recipe/recipe_ingredients.dart';
import 'package:nutripic/components/recipe/recipe_step_item.dart';
import 'package:nutripic/view_models/recipe/recipe_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:nutripic/components/recipe/recipe_info.dart';

class RecipeDetailView extends StatelessWidget {
  const RecipeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeDetailViewModel recipeDetailViewModel =
        context.watch<RecipeDetailViewModel>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 232,
            pinned: true,
            leading: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/backIcon.svg',
                width: 18,
                height: 18,
              ),
              onPressed: context.pop,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                recipeDetailViewModel.recipeModel.selectedRecipe!.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 레시피 정보
                  RecipeInfo(
                    recipe: recipeDetailViewModel.recipeModel.selectedRecipe!,
                    onPressed: () => recipeDetailViewModel.toggleFavorite(
                        recipeDetailViewModel.recipeModel.selectedRecipe!),
                  ),
                  const SizedBox(height: 24),

                  // 재료 섹션
                  RecipeIngredient(
                      ingredients: recipeDetailViewModel
                          .recipeModel.selectedRecipe!.ingredient),
                  const SizedBox(height: 36),

                  // 조리 단계 섹션
                  Column(
                    children: List.generate(
                        recipeDetailViewModel.recipeModel.selectedRecipe!
                            .procedure.length, (index) {
                      return RecipeStepItem(
                        stepNumber: index + 1,
                        stepDescription: recipeDetailViewModel
                            .recipeModel.selectedRecipe!.procedure[index],
                      );
                    }),
                  ),
                  const SizedBox(height: 12),

                  // 레시피 완료 버튼
                  SafeArea(
                    top: false,
                    bottom: true,
                    child: MainButton(
                        label: '레시피 완료',
                        onPressed: recipeDetailViewModel.onRecipeFinish),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
