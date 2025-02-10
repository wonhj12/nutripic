import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/custom_drop_down.dart';
import 'package:nutripic/components/custom_text_field.dart';
import 'package:nutripic/components/main_button.dart';
import 'package:nutripic/view_models/camera/food_edit_view_model.dart';
import 'package:provider/provider.dart';

class FoodEditView extends StatelessWidget {
  const FoodEditView({super.key});

  @override
  Widget build(BuildContext context) {
    FoodEditViewModel foodEditViewModel = context.watch<FoodEditViewModel>();

    return CustomScaffold(
      appBar: CustomAppBar(title: foodEditViewModel.appbarTitle()),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 32),

          CustomTextField(
            label: '식재료명',
            hintText: '식재료 이름을 입력하세요.',
            controller: foodEditViewModel.name,
          ),
          const SizedBox(height: 16),

          CustomDropDown(
            label: '대분류',
            hintText: '대분류를 선택하세요.',
            items: foodEditViewModel.class1,
            defaultValue: foodEditViewModel.selectedClass1,
            onChanged: (value) => foodEditViewModel.selectClass1(value),
          ),

          const SizedBox(height: 16),

          CustomDropDown(
            label: '소분류',
            hintText: '소분류를 선택하세요.',
            items: foodEditViewModel.class2,
            defaultValue: foodEditViewModel.selectedClass2,
            onChanged: (value) => foodEditViewModel.selectClass2(value),
          ),
          const SizedBox(height: 16),

          CustomDropDown(
            label: '보관 장소',
            hintText: '보관 장소를 선택하세요.',
            items: foodEditViewModel.storages,
            defaultValue: foodEditViewModel.selectedStorage?.name,
            onChanged: (value) => foodEditViewModel.selectStorage(value),
          ),
          const Spacer(),

          // 등록 버튼
          MainButton(
            label: foodEditViewModel.editButtonLabel(),
            onPressed: foodEditViewModel.onPressedSave,
          )
        ],
      ),
    );
  }
}
