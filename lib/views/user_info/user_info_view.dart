import 'package:flutter/material.dart';
import 'package:nutripic/components/user_info/button_tile.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/refrigerator/food_tile.dart';
import 'package:nutripic/components/user_info/saved_recipe_tile.dart';
import 'package:nutripic/objects/food.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/user_info/user_info_view_model.dart';
import 'package:provider/provider.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoViewModel userInfoViewModel = context.watch<UserInfoViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(
        title: '마이페이지',
        backButton: false,
      ),
      padding: 0,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 36),

            /* 프로필 */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '프로필',
                style:
                    Palette.subtitle1SemiBold.copyWith(color: Palette.gray900),
              ),
            ),
            const SizedBox(height: 16),

            // 닉네임
            Container(
              height: 24,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: userInfoViewModel.onTapEdit,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 사용자 이름
                    Text(
                      userInfoViewModel.userModel.name ?? '',
                      style: Palette.subtitle1Medium.copyWith(
                        color: Palette.gray900,
                      ),
                    ),
                    const Spacer(),

                    Text(
                      '프로필 수정하기',
                      style: Palette.caption1.copyWith(color: Palette.gray400),
                    ),
                    const SizedBox(width: 8),

                    // 화살표 아이콘
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Palette.gray900,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),

            /* 관심 레시피 */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '관심 레시피',
                style:
                    Palette.subtitle1SemiBold.copyWith(color: Palette.gray900),
              ),
            ),
            const SizedBox(height: 16),

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 16),
                  SavedRecipeTile(name: '샐러드', time: '5분', difficulty: '누구나'),
                  SizedBox(width: 6),
                  SavedRecipeTile(name: '파스타', time: '10분', difficulty: '누구나'),
                  SizedBox(width: 6),
                  SavedRecipeTile(name: '우동', time: '8분', difficulty: '누구나'),
                  SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(height: 48),

            /* 최근 사용한 식재료 */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '최근 사용한 식재료',
                style:
                    Palette.subtitle1SemiBold.copyWith(color: Palette.gray900),
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  FoodTile(
                    food: Food(
                      id: 0,
                      name: '당근',
                      icon: 'carrot',
                      class1: 'class1',
                      class2: 'class2',
                      addedDate: DateTime.now(),
                      expireDate: DateTime.now(),
                      expired: false,
                    ),
                    isSelected: false,
                    isSelectable: false,
                    select: (Food _) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            /* 도움말 */
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '도움말',
                style:
                    Palette.subtitle1SemiBold.copyWith(color: Palette.gray900),
              ),
            ),
            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ButtonTile(title: '공지사항'),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ButtonTile(title: 'FAQ'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
