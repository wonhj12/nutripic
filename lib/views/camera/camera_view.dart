import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nutripic/components/camera/camera_shutter.dart';
import 'package:nutripic/components/camera/camera_image_preview.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/box_button.dart';
import 'package:nutripic/utils/enums/box_button_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/camera/camera_view_model.dart';
import 'package:provider/provider.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    CameraViewModel cameraViewModel = context.watch<CameraViewModel>();

    return CustomScaffold(
      isLoading: cameraViewModel.isLoading ||
          !cameraViewModel.cameraModel.isCameraLoaded,
      padding: 0,
      useSafeArea: false,
      canPop: false,
      body: Column(
        children: [
          // 상단
          SizedBox(
            height: 128,
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 18),
              color: Palette.gray900, // 상단 검정 테두리
              child: IconButton(
                onPressed: cameraViewModel.onPressedClose,
                icon: const Icon(
                  Icons.close,
                  size: 24,
                  color: Palette.gray00,
                ),
              ),
            ),
          ),

          // 카메라 화면 비율과 동일하게 설정
          // 카메라 화면 확보
          // 카메라 화면 표시
          cameraViewModel.cameraModel.isCameraLoaded
              ? CameraPreview(cameraViewModel.cameraModel.controller!)
              : Container(
                  color: Palette.gray900,
                  child: const AspectRatio(aspectRatio: 3 / 4),
                ),

          // 하단
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.fromLTRB(26, 30, 26, 0),
              color: Palette.gray900,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 사진 preview
                  CameraImagePreview(
                    image: cameraViewModel.cameraModel.images.lastOrNull,
                    length: cameraViewModel.cameraModel.images.length,
                  ),

                  // 카메라 셔터
                  CameraShutter(onTap: cameraViewModel.takePicture),

                  // 완료 버튼
                  BoxButton(
                    label: '다음',
                    type: BoxButtonType.transparent,
                    onPressed: cameraViewModel.onTapComplete,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
