import 'package:flutter/material.dart';
import 'package:nutripic/components/recipe/recipe_card.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';
import 'package:nutripic/utils/palette.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeViewModel recipeViewModel = context.watch<RecipeViewModel>();

    if (recipeViewModel.recipeModel.recipes.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true, // Body를 AppBar 뒤로 확장
      appBar: AppBar(
        toolbarHeight: 24,
        backgroundColor: Colors.transparent, // 배경 투명
        elevation: 0, // 그림자 제거

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30), // 높이 30 설정
          child: Container(
            color: Colors.transparent, // 배경 투명
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
              children: [
                InkWell(
                  onTap: () {
                    // 추천 필터 선택 로직
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 필요한 만큼만 공간 차지
                    children: [
                      Text(
                        "추천",
                        style: Palette.title1SemiBold
                            .copyWith(color: Colors.white),
                      ),
                      Container(
                        width: 35, // 밑줄의 너비
                        height: 2, // 밑줄의 높이
                        color: Colors.white, // 밑줄 색상
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // 추천과 전체 간의 간격
                InkWell(
                  onTap: () {
                    recipeViewModel.onRecipeSearch();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 필요한 만큼만 공간 차지
                    children: [
                      Text(
                        "전체",
                        style: Palette.title1SemiBold
                            .copyWith(color: Palette.gray200),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
