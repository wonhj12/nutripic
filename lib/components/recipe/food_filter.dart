import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/utils/palette.dart';

class FoodFilter extends StatelessWidget {
  const FoodFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      width: double.infinity,
      height: 41,
      decoration: BoxDecoration(
        color: Palette.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [Palette.shadow],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/foods/carrot.svg',
            fit: BoxFit.contain,
          ),
          SvgPicture.asset(
            'assets/foods/carrot.svg',
            fit: BoxFit.contain,
          ),
          SvgPicture.asset(
            'assets/foods/carrot.svg',
            fit: BoxFit.contain,
          ),
          SvgPicture.asset(
            'assets/foods/chicken_breast.svg',
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
