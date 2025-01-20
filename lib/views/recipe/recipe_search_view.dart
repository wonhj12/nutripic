import 'package:flutter/material.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class RecipeSearchView extends StatelessWidget {
  String query = "";

  RecipeSearchView({super.key}); // 검색어 저장 변수

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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "레시피 검색",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
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
                          backgroundImage: NetworkImage(
                              filteredRecipes[index].imageUrl ?? ""),
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
