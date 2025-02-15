import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/image_confirm_preview.dart';

class ImageConfirmGrid extends StatelessWidget {
  /// 이미지 리스트
  final List<File> images;

  /// 선택 가능 여부
  final bool isSelectable;

  /// 선택 됨 여부
  final bool Function(int) isSelected;

  /// 이미지 선택 함수
  final Function(int) select;

  const ImageConfirmGrid({
    super.key,
    required this.images,
    required this.isSelectable,
    required this.isSelected,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: images.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 108 / 144,
        ),
        itemBuilder: (context, index) => ImageConfirmPreview(
          image: images[index],
          isSelectable: isSelectable,
          isSelected: isSelected(index),
          select: () => select(index),
        ),
      ),
    );
  }
}
