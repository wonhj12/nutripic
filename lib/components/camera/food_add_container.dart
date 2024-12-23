import 'package:flutter/material.dart';
import 'package:nutripic/components/camera/recognized_food_tile.dart';
import 'package:nutripic/utils/palette.dart';

class FoodAddContainer extends StatelessWidget {
  final Set<String> recognizedFoods;
  const FoodAddContainer({super.key, required this.recognizedFoods});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 36),

        // 타이틀
        Row(
          children: [
            const Text('냉장보관', style: Palette.title),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_rounded))
          ],
        ),
        const SizedBox(height: 16),

        // 인식한 식재료 컨테이너
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Palette.background,
            border: Border.all(color: Palette.gray200),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recognizedFoods.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) =>
                RecognizedFoodTile(
              name: recognizedFoods.elementAt(index),
              onTapEdit: () {},
              onTapDelete: () {},
            ),
          ),
        ),
      ],
    );
  }
}
