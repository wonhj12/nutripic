import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nutripic/components/camera/camera_shutter.dart';
import 'package:nutripic/components/camera/image_preview.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/select_button.dart';
import 'package:nutripic/utils/enums/select_button_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/camera/camera_view_model.dart';
import 'package:provider/provider.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    CameraViewModel cameraViewModel = context.watch<CameraViewModel>();

    return CustomScaffold(
      isLoading: cameraViewModel.isLoading || !cameraViewModel.isCameraLoaded,
      padding: 0,
      useSafeArea: false,
      body: Column(
        children: [
          // 상단
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.fromLTRB(26, 0, 26, 30),
              color: Palette.black, // 상단 검정 테두리
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 닫기 버튼
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                      color: Palette.white,
                    ),
                  ),

                  // 전환 버튼
                  IconButton(
                    onPressed: cameraViewModel.changeCameraDirection,
                    icon: const Icon(
                      Icons.restart_alt_rounded,
                      size: 24,
                      color: Palette.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 카메라 화면 비율과 동일하게 설정
          // 카메라 화면 확보

          // 카메라 화면 표시
          cameraViewModel.isCameraLoaded
              ? CameraPreview(cameraViewModel.controller)
              : Container(
                  color: Palette.black,
                  child: const AspectRatio(aspectRatio: 3 / 4),
                ),

          // 하단
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.fromLTRB(26, 28, 26, 0),
              color: Palette.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 사진 preview
                  ImagePreview(
                    image: cameraViewModel.images.lastOrNull,
                    length: cameraViewModel.images.length,
                  ),

                  // 카메라 셔터
                  CameraShutter(onTap: cameraViewModel.takePicture),

                  // 완료 버튼
                  SelectButton(
                    label: '완료',
                    type: SelectButtonType.delete,
                    onPressed: () {},
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
