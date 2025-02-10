import 'package:flutter/material.dart';
import 'package:nutripic/utils/enums/icon_selection_type.dart';
import 'package:nutripic/utils/palette.dart';

class IconSelection extends StatelessWidget {
  final bool isSelected;
  final IconSelectionType type;

  const IconSelection({
    super.key,
    required this.isSelected,
    this.type = IconSelectionType.small,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: type.size,
      height: type.size,
      decoration: BoxDecoration(
        color: isSelected ? type.activeFillColor : type.inactiveFillColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? type.activeStrokeColor : type.inactiveStrokeColor,
          width: type.strokeWidth,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check_rounded, color: Palette.gray00, size: 12)
          : Container(),
    );
  }
}
