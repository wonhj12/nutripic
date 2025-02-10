import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/icon_selection.dart';

class FoodSelect extends StatelessWidget {
  final bool isSelected;
  const FoodSelect({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4,
      left: 4,
      child: IconSelection(isSelected: isSelected),
    );
  }
}
