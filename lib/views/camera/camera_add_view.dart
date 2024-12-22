import 'package:flutter/material.dart';
import 'package:nutripic/components/camera/food_add_container.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/main_button.dart';
import 'package:nutripic/view_models/camera/camera_add_view_model.dart';
import 'package:provider/provider.dart';

class CameraAddView extends StatelessWidget {
  const CameraAddView({super.key});

  @override
  Widget build(BuildContext context) {
    CameraAddViewModel cameraAddViewModel = context.watch<CameraAddViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(title: '분석 결과'),
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 인식된 식재료 리스트
              FoodAddContainer(
                recognizedFoods:
                    cameraAddViewModel.refrigeratorModel.recognizedFoods,
              ),
              const SizedBox(height: 32),

              // 보관 버튼
              MainButton(
                label: '보관하기',
                onPressed: cameraAddViewModel.onPressedSave,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
