import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/recipe/recipe_ingredients.dart';
import 'package:nutripic/components/recipe/recipe_step_item.dart';
import 'package:nutripic/objects/recipe.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/recipe/recipe_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:nutripic/components/recipe/recipe_info.dart';

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
              icon: SvgPicture.asset(
                'assets/icons/backIcon.svg',
                width: 18,
                height: 18,
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
                  RecipeIngredient(ingredients: recipe.ingredient),

                  const SizedBox(height: 36),
                  // 조리 단계 섹션
                  Column(
                    children: List.generate(recipe.procedure.length, (index) {
                      return RecipeStepItem(
                        stepNumber: index + 1,
                        stepDescription: recipe.procedure[index],
                      );
                    }),
                  ),
                  const Divider(
                    thickness: 0.5, // 구분선 두께 조정
                    color: Colors.black26,
                  ),
                  const SizedBox(height: 12),
                  // 레시피 완료 버튼
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        recipeDetailViewModel.onRecipeFinish();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(
                            343, 50), // Figma에서 설정된 크기 (너비 343, 높이 50)
                        backgroundColor: Palette.green500,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Figma에서 반경 8px
                        ),
                        elevation: 0, // 그림자 제거
                        padding: EdgeInsets.zero, // 내부 패딩 제거
                      ),
                      child: Text(
                        '레시피 완료',
                        style: Palette.title2SemiBold
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 42),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
