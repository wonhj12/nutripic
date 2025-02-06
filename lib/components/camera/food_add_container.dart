import 'package:flutter/material.dart';
import 'package:nutripic/components/camera/recognized_food_tile.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/palette.dart';

class FoodAddContainer extends StatelessWidget {
  final String title;
  final List<Food> recognizedFoods;
  final bool isSelectState;
  const FoodAddContainer({
    super.key,
    required this.title,
    required this.recognizedFoods,
    required this.isSelectState,
  });

  @override
  Widget build(BuildContext context) {
    return recognizedFoods.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 타이틀
              Text(title, style: Palette.title1Medium),
              const SizedBox(height: 16),

              // 인식한 식재료 컨테이너
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Palette.gray00,
                  border: Border.all(color: Palette.gray200),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recognizedFoods.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Palette.gray100,
                    height: 12,
                  ),
                  itemBuilder: (BuildContext context, int index) =>
                      RecognizedFoodTile(
                    food: recognizedFoods.elementAt(index),
                    isSelectState: isSelectState,
                    onTapEdit: () {},
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          )
        : Container();
  }
}
