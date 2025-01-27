import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/recipe/food_icon.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/recipe/recipe_view_model.dart';
import 'package:provider/provider.dart';

class FoodFilter extends StatelessWidget {
  const FoodFilter({super.key});

  @override
  Widget build(BuildContext context) {
    RecipeViewModel recipeViewModel = context.watch<RecipeViewModel>();
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      width: double.infinity,
      height: 41,
      decoration: BoxDecoration(
        color: Palette.gray00,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [Palette.shadow],
      ),
      child: Row(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FoodIcon(),
                  FoodIcon(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              recipeViewModel.showFilterDialog(context);
            },
            borderRadius: BorderRadius.circular(8),
            splashColor: Colors.grey.withOpacity(0.3),
            child: Container(
              margin: const EdgeInsets.only(right: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [Palette.shadow],
              ),
              child: SvgPicture.asset(
                'assets/icons/filter.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
