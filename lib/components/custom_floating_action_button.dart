import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

/// Custom Button 타입
enum ButtonType {
  green(Palette.primary),
  gray(Palette.gray200);

  final Color color;
  const ButtonType(this.color);
}

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final ButtonType type;
  final Function()? onPressed;
  final String heroTag;
  final double animatedPositionBottom;
  final double opacity;

  const CustomFloatingActionButton({
    super.key,
    required this.icon,
    required this.type,
    required this.onPressed,
    required this.heroTag,
    this.animatedPositionBottom = -1,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return animatedPositionBottom > -1
        ? AnimatedPositioned(
            bottom: animatedPositionBottom,
            right: 0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                heroTag: heroTag,
                onPressed: onPressed,
                backgroundColor: type.color,
                shape: const CircleBorder(),
                child: Icon(
                  icon,
                  color: Palette.white,
                ),
              ),
            ),
          )
        : Positioned(
            bottom: 0,
            right: 0,
            child: FloatingActionButton(
              heroTag: heroTag,
              onPressed: onPressed,
              backgroundColor: type.color,
              shape: const CircleBorder(),
              child: Icon(
                icon,
                color: Palette.white,
              ),
            ),
          );
  }
}
