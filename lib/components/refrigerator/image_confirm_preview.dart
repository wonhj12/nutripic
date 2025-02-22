import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/image_confirm_select.dart';
import 'package:nutripic/utils/palette.dart';

/// Image Confirm Grid에서 사용되는 이미지
class ImageConfirmPreview extends StatelessWidget {
  /// 사진
  final File image;

  /// 사진 선택 가능 여부
  final bool isSelectable;

  /// 사진 선택 됨 여부
  final bool isSelected;

  /// 사진 선택시 콜백 함수
  final Function() select;

  const ImageConfirmPreview({
    super.key,
    required this.image,
    required this.isSelectable,
    required this.isSelected,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => select(),
      child: Container(
        width: 108,
        height: 144,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // 선택 시 테두리
          border: Border.all(
            color: isSelected ? Palette.green400 : Colors.transparent,
            width: 2,
          ),
        ),
        // 이미지
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // 식재료 사진
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                image,
                fit: BoxFit.cover,
              ),
            ),

            // 선택 체크
            if (isSelectable) ImageConfirmSelect(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}
