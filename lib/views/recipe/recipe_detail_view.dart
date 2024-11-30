import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/recipe/recipe_detail_view_model.dart';
import 'package:provider/provider.dart';

class RecipeDetailView extends StatelessWidget {
  RecipeDetailView({super.key});

  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    RecipeDetailViewModel recipeDetailViewModel =
        context.watch<RecipeDetailViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 232,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                recipeDetailViewModel.recipeModel.specificRecipe?.imageSource ??
                    'assets/foods/buldak_noodle.png',
                fit: BoxFit.fitWidth,
              ),
              title: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  recipeDetailViewModel
                          .recipeModel.specificRecipe?.recipeName ??
                      'Name Error',
                  style: Palette.headingWhite,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text("asdf"),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    SizedBox(
                      child: Text("asdf"),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  color: Colors.yellow,
                  width: 343,
                  height: 150,
                  child: const Text("Ingredients"),
                ),
                const SizedBox(
                  height: 56,
                ),
                Container(
                  color: Colors.black12,
                  width: 343,
                  child: const Text("recipeaklsdj;falksdjf;\nasdfa;sdfasdl"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
