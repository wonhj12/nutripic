import 'package:flutter/material.dart';
import 'package:nutripic/components/camera/image_confirm_grid.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/main_button.dart';
import 'package:nutripic/components/box_button.dart';
import 'package:nutripic/utils/enums/box_button_type.dart';
import 'package:nutripic/view_models/camera/camera_confirm_view_model.dart';
import 'package:provider/provider.dart';

class CameraConfirmView extends StatelessWidget {
  const CameraConfirmView({super.key});

  @override
  Widget build(BuildContext context) {
    CameraConfirmViewModel cameraConfirmViewModel =
        context.watch<CameraConfirmViewModel>();

    return CustomScaffold(
      appBar: CustomAppBar(
        title: '카메라로 돌아가기',
        centerTitle: false,
        actions: [
          // 취소 버튼 (선택 시에만 활성화)
          if (cameraConfirmViewModel.isSelectable)
            BoxButton(
              label: '취소',
              onPressed: cameraConfirmViewModel.onTapCancel,
            ),
          if (cameraConfirmViewModel.isSelectable) const SizedBox(width: 8),

          // 삭제, 선택 버튼
          cameraConfirmViewModel.isSelectable
              ? BoxButton(
                  label: '삭제',
                  type: BoxButtonType.delete,
                  onPressed: cameraConfirmViewModel.onTapDelete,
                )
              : BoxButton(
                  label: '선택',
                  onPressed: cameraConfirmViewModel.onTapSelect,
                ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 18),
          // 이미지 그리드
          ImageConfirmGrid(
            images: cameraConfirmViewModel.cameraModel.images,
            isSelectable: cameraConfirmViewModel.isSelectable,
            isSelected: cameraConfirmViewModel.isSelected,
            select: cameraConfirmViewModel.selectImage,
          ),

          // 분석 버튼
          MainButton(
            label: '분석하기',
            onPressed: cameraConfirmViewModel.onTapSend,
          ),
        ],
      ),
    );
  }
}
