import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class RefrigeratorSearchContainer extends StatelessWidget {
  /// 식재료 추가 카메라 버튼
  final Function()? onPressedCamera;

  const RefrigeratorSearchContainer({
    super.key,
    required this.onPressedCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Palette.gray00,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Palette.gray200, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 검색 텍스트
          Text(
            '추가할 식재료를 검색해 보세요',
            style: Palette.body1.copyWith(color: Palette.gray300),
          ),

          const Spacer(),

          // 구분선
          const SizedBox(
            height: 12,
            child: VerticalDivider(color: Palette.gray500),
          ),

          // 사진 촬영 버튼
          IconButton(
            onPressed: onPressedCamera,
            icon: const Icon(
              Icons.camera_alt_outlined,
              size: 24,
              color: Palette.gray500,
            ),
          )
        ],
      ),
    );
  }
}
