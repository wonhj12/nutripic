import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

class CameraImagePreview extends StatelessWidget {
  final File? image;
  final int length;
  const CameraImagePreview(
      {super.key, required this.image, required this.length});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Palette.gray800,
            borderRadius: BorderRadius.circular(10),
          ),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(image!, fit: BoxFit.cover),
                )
              : const Icon(
                  Icons.camera_alt_outlined,
                  color: Palette.gray00,
                ),
        ),

        // 개수
        if (length > 0)
          Positioned(
            right: -8,
            top: -8,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.green500,
              ),
              child: Center(
                child: Text(
                  '$length',
                  style: Palette.body1.copyWith(
                      color: Palette.gray00, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
      ],
    );
  }
}
