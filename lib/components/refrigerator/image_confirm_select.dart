import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/icon_selection.dart';
import 'package:nutripic/utils/enums/icon_selection_type.dart';

class ImageConfirmSelect extends StatelessWidget {
  final bool isSelected;
  const ImageConfirmSelect({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 6,
      right: 6,
      child: IconSelection(
        isSelected: isSelected,
        type: IconSelectionType.large,
      ),
    );
  }
}
