import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class RecognizedFoodTile extends StatelessWidget {
  final String name;
  const RecognizedFoodTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        // 식재료 이미지
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Palette.gray100,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 16),

        // 식재료 이름
        Text(name),

        // 버튼
      ],
    );
  }
}
