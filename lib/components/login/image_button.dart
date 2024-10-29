import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageButton extends StatelessWidget {
  final String img;
  final double width;
  final double height;
  final Function()? onTap;
  const ImageButton({
    super.key,
    required this.img,
    this.width = 300,
    this.height = 45,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(img, width: width, height: height),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              width: width,
              height: height,
            ),
          ),
        )
      ],
    );
  }
}
