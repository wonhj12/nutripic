import 'package:flutter/material.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
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
    RecipeViewModel recipeViewModel = context.watch<RecipeViewModel>();

    // 검색 결과 필터링
    final filteredRecipes = recipeViewModel.recipeModel.recipes
        .where((recipe) => recipe.name.contains(query))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("레시피 검색"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: const InputDecoration(
                hintText: "레시피 검색",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.filter_alt_sharp),
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
                        title: Text(filteredRecipes[index].name),
                        subtitle:
                            Text('${filteredRecipes[index].cookingTime}분 이내'),
                        trailing: IconButton(
                          icon: Icon(
                            filteredRecipes[index].isFavorite == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          onPressed: () {
                            recipeViewModel
                                .toggleFavorite(filteredRecipes[index]);
                          },
                        ),
                        onTap: () {
                          recipeViewModel.onTapDetail(filteredRecipes[index]);
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
