import 'package:flutter/material.dart';
import 'package:nutripic/components/image_button.dart';
import 'package:nutripic/utils/palette.dart';

class RecognizedFoodTile extends StatelessWidget {
  final String name;
  final Function()? onTapEdit;
  final Function()? onTapDelete;

  /// `name = filename.svg`
  const RecognizedFoodTile({
    super.key,
    required this.name,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 유통기한
            Text(
              'D-5',
              style: Palette.subbody.copyWith(
                color: Palette.delete,
                fontWeight: FontWeight.w500,
              ),
            ),

            // 식재료 이름
            Text(name, style: Palette.title),
          ],
        ),

        const Spacer(),

        // 수정 버튼
        ImageButton(
          img: '/edit.svg',
          width: 24,
          height: 24,
          onTap: onTapEdit,
        ),
        const SizedBox(width: 24),

        // 삭제 버튼
        ImageButton(
          img: '/trash.svg',
          width: 24,
          height: 24,
          onTap: onTapDelete,
        ),
      ],
    );
  }
}
