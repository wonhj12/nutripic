import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final String img;
  final Function()? onTap;
  const ImageButton({
    super.key,
    this.width = 300,
    this.height = 45,
    this.radius = 8,
    required this.img,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset('assets/icons/$img', width: width, height: height),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(radius),
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
