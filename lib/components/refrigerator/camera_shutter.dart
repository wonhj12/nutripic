import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class CameraShutter extends StatelessWidget {
  final void Function()? onTap;
  const CameraShutter({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.gray00,
              ),
            ),

            // 안쪽 링
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: Palette.black,
                border: Border.all(color: Palette.gray900, width: 4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
