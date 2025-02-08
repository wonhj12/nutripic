import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/recipe/recipe_search_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:nutripic/objects/food.dart';

class RecipeSearchView extends StatefulWidget {
  const RecipeSearchView({super.key});

  @override
  _RecipeSearchViewState createState() => _RecipeSearchViewState();
}

class _RecipeSearchViewState extends State<RecipeSearchView> {
  String query = "";
  List<Food> selectedFoods = []; // 선택된 식재료 리스트

  @override
  Widget build(BuildContext context) {
    RecipeSearchViewModel recipeSearchViewModel =
        context.watch<RecipeSearchViewModel>();

    // 검색 결과 필터링
    final filteredRecipes = recipeSearchViewModel.recipeModel.recipes
        .where((recipe) => recipe.name.contains(query))
        .toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 24,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30), // 높이 30 설정
          child: Container(
            color: Colors.transparent, // 배경 투명
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
              children: [
                InkWell(
                  onTap: () {
                    recipeSearchViewModel.onRecipeView();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 필요한 만큼만 공간 차지
                    children: [
                      Text(
                        "추천",
                        style: Palette.title1SemiBold
                            .copyWith(color: Palette.gray200),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // 추천과 전체 간의 간격
                InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // 필요한 만큼만 공간 차지
                    children: [
                      Text(
                        "전체",
                        style: Palette.title1SemiBold
                            .copyWith(color: Palette.gray900),
                      ),
                      Container(
                        width: 35, // 밑줄의 너비
                        height: 2, // 밑줄의 높이
                        color: Palette.gray900, // 밑줄 색상
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Palette.gray50,
                  hintText: "원하는 레시피를 검색해보세요",
                  hintStyle:
                      Palette.body1.copyWith(color: const Color(0xff999ba9)),
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 10,
                    height: 10,
                    fit: BoxFit.scaleDown,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/recipe_filter.svg',
                  width: 24,
                  height: 24,
                ),
                onPressed: () async {
                  // 필터 화면으로 이동하고 선택된 식재료 데이터를 받아옴
                  final result =
                      await context.push<List<Food>>('/recipe/search/filter');

                  if (result != null) {
                    setState(() {
                      selectedFoods = result; // 선택된 식재료 저장
                    });
                  }
                },
              ),
              if (selectedFoods.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: selectedFoods
                          .map((food) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Chip(
                                  label: Text(food.name),
                                  onDeleted: () {
                                    setState(() {
                                      selectedFoods.remove(food);
                                    });
                                  },
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              if (selectedFoods.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '식재료 필터를 적용해보세요',
                    style: TextStyle(
                        color: Color(0xff91969d), // 힌트 스타일 색상
                        fontSize: 14,
                        fontWeight: FontWeight.w400 // 힌트 텍스트 크기
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
          Expanded(
            child: filteredRecipes.isEmpty
                ? const Center(
                    child: Text("검색 결과가 없습니다."),
                  )
                : ListView.builder(
                    itemCount: filteredRecipes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(filteredRecipes[index].imageUrl),
                        ),
                        title: Text(
                          filteredRecipes[index].name,
                          style: Palette.subtitle1Medium,
                        ),
                        subtitle: Row(
                          children: [
                            Row(
                              children: List.generate(3, (starIndex) {
                                return Icon(
                                  starIndex < filteredRecipes[index].difficulty
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Palette.green600,
                                  size: 15, // 별 크기
                                );
                              }),
                            ),
                            const SizedBox(
                              width: 10, //추후 수정 필요
                            ),
                            Text(
                              '${filteredRecipes[index].cookingTime}분 이내',
                              style: Palette.caption1.copyWith(
                                color: Palette.success,
                              ),
                            )
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            filteredRecipes[index].isFavorite == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {
                            recipeSearchViewModel
                                .toggleFavorite(filteredRecipes[index]);
                          },
                        ),
                        onTap: () {
                          recipeSearchViewModel
                              .onTapDetail(filteredRecipes[index]);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
