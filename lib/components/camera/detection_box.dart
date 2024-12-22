import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:pytorch_lite/pigeon.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

class DetectionBox extends StatelessWidget {
  final ResultObjectDetection result;
  final Size screenSize;
  const DetectionBox({
    super.key,
    required this.result,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    double factorX = screenSize.width;
    double factorY = screenSize.height;

    return Positioned(
      left: result.rect.left * factorX,
      top: result.rect.top * factorY,
      width: result.rect.width * factorX,
      height: result.rect.height * factorY,
      child: Container(
        width: result.rect.width * factorX,
        height: result.rect.height * factorY,
        decoration: BoxDecoration(
          border: Border.all(color: Palette.sub, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(2)),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: Palette.sub,
            child: Text(
                '${result.className ?? result.classIndex.toString()} ${result.score.toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }
}
