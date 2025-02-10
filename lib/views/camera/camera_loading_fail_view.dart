import 'package:flutter/material.dart';
import 'package:nutripic/components/box_button.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/utils/enums/box_button_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/camera/camera_loading_fail_view_model.dart';
import 'package:provider/provider.dart';

class CameraLoadingFailView extends StatelessWidget {
  const CameraLoadingFailView({super.key});

  @override
  Widget build(BuildContext context) {
    CameraLoadingFailViewModel cameraLoadingFailViewModel =
        context.watch<CameraLoadingFailViewModel>();

    return CustomScaffold(
      canPop: false,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '분석에 실패했어요',
              style: Palette.title1Medium.copyWith(color: Palette.green600),
            ),
            const SizedBox(height: 24),
            BoxButton(
              label: '다시 분석하기',
              type: BoxButtonType.primary,
              s: false,
              width: 100,
              onPressed: cameraLoadingFailViewModel.onPressedRedo,
            ),
          ],
        ),
      ),
    );
  }
}
