import 'package:flutter/material.dart';
import 'package:nutripic/components/box_button.dart';
import 'package:nutripic/components/camera/food_add_container.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/main_button.dart';
import 'package:nutripic/utils/enums/box_button_type.dart';
import 'package:nutripic/utils/enums/main_button_type.dart';
import 'package:nutripic/utils/enums/storage_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/camera/camera_add_view_model.dart';
import 'package:provider/provider.dart';

class CameraAddView extends StatelessWidget {
  const CameraAddView({super.key});

  @override
  Widget build(BuildContext context) {
    CameraAddViewModel cameraAddViewModel = context.watch<CameraAddViewModel>();

    return CustomScaffold(
      appBar: CustomAppBar(
        title: '분석 결과',
        closeButton: true,
        onPressedLeading: cameraAddViewModel.onPressClose,
        actions: [
          BoxButton(
            label: cameraAddViewModel.isSelectState ? '취소' : '선택',
            onPressed: cameraAddViewModel.onPressSelect,
          ),
        ],
      ),
      canPop: false,
      isLoading: cameraAddViewModel.isLoading,
      body: CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 32),

                // 인식된 식재료 리스트
                FoodAddContainer(
                  title: '냉장보관',
                  recognizedFoods:
                      cameraAddViewModel.cameraModel.analyzedFoods[0],
                  selectedFoods:
                      cameraAddViewModel.cameraModel.selectedRefrigerator,
                  isSelectState: cameraAddViewModel.isSelectState,
                  select: cameraAddViewModel.selectRefrigeratorFood,
                  onTapEdit: (food) => cameraAddViewModel.onPressedEdit(
                    food: food,
                    storage: StorageType.fridge,
                  ),
                ),

                // 인식된 식재료 리스트
                FoodAddContainer(
                  title: '냉동보관',
                  recognizedFoods:
                      cameraAddViewModel.cameraModel.analyzedFoods[1],
                  selectedFoods: cameraAddViewModel.cameraModel.selectedFreezer,
                  isSelectState: cameraAddViewModel.isSelectState,
                  select: cameraAddViewModel.selectFreezerFood,
                  onTapEdit: (food) => cameraAddViewModel.onPressedEdit(
                    food: food,
                    storage: StorageType.freezer,
                  ),
                ),

                // 인식된 식재료 리스트
                FoodAddContainer(
                  title: '실온보관',
                  recognizedFoods:
                      cameraAddViewModel.cameraModel.analyzedFoods[2],
                  selectedFoods: cameraAddViewModel.cameraModel.selectedRoom,
                  isSelectState: cameraAddViewModel.isSelectState,
                  select: cameraAddViewModel.selectRoomFood,
                  onTapEdit: (food) => cameraAddViewModel.onPressedEdit(
                    food: food,
                    storage: StorageType.room,
                  ),
                ),
              ],
            ),
          ),

          // Spacer로 하단 분리
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),

                // 식재료 등록 문구
                if (!cameraAddViewModel.isSelectState)
                  Text(
                    '찾는 재료가 없다면, 식재료를 새로 등록해보세요.',
                    style: Palette.caption2.copyWith(color: Palette.gray400),
                  ),
                if (!cameraAddViewModel.isSelectState)
                  const SizedBox(height: 20),

                // 새 식재료 등록 버튼
                if (!cameraAddViewModel.isSelectState)
                  BoxButton(
                    label: '등록하기',
                    type: BoxButtonType.primary,
                    s: false,
                    onPressed: cameraAddViewModel.onPressedEdit,
                  ),
                if (!cameraAddViewModel.isSelectState)
                  const SizedBox(height: 40),

                // 보관 버튼
                MainButton(
                  label: cameraAddViewModel.isSelectState ? '삭제하기' : '보관하기',
                  type: cameraAddViewModel.isSelectState
                      ? MainButtonType.delete
                      : MainButtonType.enabled,
                  onPressed: cameraAddViewModel.onPressedSave,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
