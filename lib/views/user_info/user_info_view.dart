import 'package:flutter/material.dart';
import 'package:nutripic/components/button_tile.dart';
import 'package:nutripic/components/custom_app_bar.dart';
import 'package:nutripic/components/custom_scaffold.dart';
import 'package:nutripic/components/profile_image.dart';
import 'package:nutripic/components/food_tile.dart';
import 'package:nutripic/components/saved_recipe_tile.dart';
import 'package:nutripic/main.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* 프로필 */
            InkWell(
              onTap: () => userInfoViewModel.onTapEdit(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 프로필 이미지
                  ProfileImage(src: userModel.profileUrl),
                  const SizedBox(width: 20),

                  // 사용자 이름
                  Text(
                    userInfoViewModel.userModel.name ?? 'null',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),

                  // 화살표 아이콘
                  const Icon(Icons.arrow_forward_ios, size: 16)
                ],
              ),
            ),
            const SizedBox(height: 36),

            /* 나의 기록 */
            const Text(
              '나의 기록',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 88,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: const Color(0xFFB5B5B5)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 36),

            /* 저장한 레시피 */
            const Text(
              '저장한 레시피',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SavedRecipeTile(name: '샐러드', time: '5분', difficulty: '누구나'),
                  SizedBox(width: 8),
                  SavedRecipeTile(name: '파스타', time: '10분', difficulty: '누구나'),
                  SizedBox(width: 8),
                  SavedRecipeTile(name: '우동', time: '8분', difficulty: '누구나'),
                ],
              ),
            ),
            const SizedBox(height: 36),

            /* 많이 쓴 식재료 */
            const Text(
              '많이 쓴 식재료',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                FoodTile(src: userModel.profileUrl, name: '양파'),
                const SizedBox(width: 12),
                const FoodTile(src: null, name: '마늘'),
                const SizedBox(width: 12),
                const FoodTile(src: null, name: '파프리카'),
              ],
            ),
            const SizedBox(height: 36),

            /* 도움말 */
            const Text(
              '도움말',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const ButtonTile(title: '공지사항'),
            const SizedBox(height: 8),
            const ButtonTile(title: 'FAQ'),
            const SizedBox(height: 8),
            const ButtonTile(title: '문의하기'),
          ],
        ),
      ),
    );
  }
}
