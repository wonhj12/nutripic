import 'package:flutter/material.dart';
import 'package:nutripic/components/refrigerator/refrigerator_search_container.dart';
import 'package:nutripic/components/box_button.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/refrigerator_container.dart';
import 'package:nutripic/components/refrigerator/refrigerator_select_container.dart';
import 'package:nutripic/utils/enums/box_button_type.dart';
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
      backgroundColor: Palette.green500,
      padding: 0,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 검색 바
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: RefrigeratorSearchContainer(
                  onPressedCamera: refrigeratorViewModel.onTapCamera,
                ),
              ),
              const SizedBox(height: 44),

              // 보유 식재료, 선택 버튼
              Expanded(
                child: Container(
                  color: Palette.gray00,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 52),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 32,
                            child: Center(
                              child: Text(
                                '보유한 식재료',
                                style: Palette.title2SemiBold.copyWith(
                                  color: Palette.gray900,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),

                          // 취소 버튼
                          if (refrigeratorViewModel.isSelectable)
                            BoxButton(
                              label: '취소',
                              onPressed: refrigeratorViewModel.onTapCancel,
                            ),
                          const SizedBox(width: 8),

                          if (refrigeratorViewModel.refrigeratorModel
                              .hasFoods())
                            refrigeratorViewModel.isSelectable
                                // 삭제 버튼
                                ? BoxButton(
                                    label: '삭제',
                                    type: BoxButtonType.delete,
                                    onPressed:
                                        refrigeratorViewModel.onTapDelete,
                                  )
                                // 선택 버튼
                                : BoxButton(
                                    label: '편집',
                                    onPressed:
                                        refrigeratorViewModel.onTapSelect,
                                  ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // 식재료 컨테이너
                      RefrigeratorContainer(
                        foods: refrigeratorViewModel.refrigeratorModel
                            .foods[refrigeratorViewModel.storage.rawValue],
                        expiredFoods: refrigeratorViewModel
                                .refrigeratorModel.expiredFoods[
                            refrigeratorViewModel.storage.rawValue],
                        selectedFoods: refrigeratorViewModel
                            .refrigeratorModel.selectedFoods,
                        selectedExpiredFoods: refrigeratorViewModel
                            .refrigeratorModel.selectedExpiredFoods,
                        isSelectable: refrigeratorViewModel.isSelectable,
                        addFood: refrigeratorViewModel.onTapCamera,
                        selectFood: refrigeratorViewModel.selectFood,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 냉장고 선택
          Positioned(
            top: 90,
            child: RefrigeratorSelectContainer(
              selected: refrigeratorViewModel.storage,
              onTapRefrigerator: refrigeratorViewModel.onTapRefrigerator,
              onTapFreezer: refrigeratorViewModel.onTapFreezer,
              onTapCabinet: refrigeratorViewModel.onTapCabinet,
            ),
          ),
        ],
      ),
    );
  }
}
