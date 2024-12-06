import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/select_button.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/refrigerator_container.dart';
import 'package:nutripic/components/refrigerator/refrigerator_select_container.dart';
import 'package:nutripic/utils/enums/select_button_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/refrigerator/refrigerator_view_model.dart';
import 'package:provider/provider.dart';

class RefrigeratorView extends StatelessWidget {
  const RefrigeratorView({super.key});

  @override
  Widget build(BuildContext context) {
    RefrigeratorViewModel refrigeratorViewModel =
        context.watch<RefrigeratorViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(backButton: false),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 26),

          // 헤더
          Row(
            children: [
              const Text('나의 냉장고', style: Palette.heading),
              const Spacer(),
              IconButton(
                onPressed: refrigeratorViewModel.onTapCamera,
                icon: const Icon(
                  Icons.camera,
                ),
              ),
              refrigeratorViewModel.isSelectable
                  // 취소 버튼
                  ? SelectButton(
                      label: '취소',
                      type: SelectButtonType.cancel,
                      onPressed: refrigeratorViewModel.onTapCancel,
                    )
                  // 정렬
                  : const Text('추가한 순', style: Palette.body),
              const SizedBox(width: 15),
              refrigeratorViewModel.isSelectable
                  // 삭제 버튼
                  ? SelectButton(
                      label: '삭제',
                      type: SelectButtonType.delete,
                      onPressed: refrigeratorViewModel.onTapDelete,
                    )
                  // 선택 버튼
                  : SelectButton(
                      label: '선택', onPressed: refrigeratorViewModel.onTapSelect)
            ],
          ),
          const SizedBox(height: 12),

          // 냉장고
          RefrigeratorContainer(
            foods: refrigeratorViewModel.refrigeratorModel
                .foods[refrigeratorViewModel.storage.rawValue],
            selectedFoods: refrigeratorViewModel.selectedFoods,
            isSelectable: refrigeratorViewModel.isSelectable,
            addFood: null,
            selectFood: refrigeratorViewModel.selectFood,
          ),
          const SizedBox(height: 15),

          // 냉장고 선택 버튼
          RefrigeratorSelectContainer(
            selected: refrigeratorViewModel.storage,
            onTapRefrigerator: refrigeratorViewModel.onTapRefrigerator,
            onTapFreezer: refrigeratorViewModel.onTapFreezer,
            onTapCabinet: refrigeratorViewModel.onTapCabinet,
          ),
          const SizedBox(height: 34),
        ],
      ),
    );
  }
}
