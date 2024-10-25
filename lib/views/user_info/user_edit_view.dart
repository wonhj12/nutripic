import 'package:flutter/material.dart';
import 'package:nutripic/components/button_tile.dart';
import 'package:nutripic/components/custom_app_bar.dart';
import 'package:nutripic/components/custom_scaffold.dart';
import 'package:nutripic/components/custom_text_field.dart';
import 'package:nutripic/components/user_info/profile_image.dart';
import 'package:nutripic/main.dart';
import 'package:nutripic/view_models/user_info/user_edit_view_model.dart';
import 'package:provider/provider.dart';

class UserEditView extends StatefulWidget {
  const UserEditView({super.key});

  @override
  State<UserEditView> createState() => _UserEditViewState();
}

class _UserEditViewState extends State<UserEditView> {
  @override
  Widget build(BuildContext context) {
    UserEditViewModel userEditViewModel = context.watch<UserEditViewModel>();
    return CustomScaffold(
      appBar: const CustomAppBar(title: '프로필 수정'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            /* 프로필 사진 */
            Center(
              child: ProfileImage(
                src: userEditViewModel.userModel.profileUrl,
                radius: 102,
              ),
            ),
            const SizedBox(height: 55),

            /* 닉네임 */
            const Text(
              '닉네임',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              initialValue: userModel.name,
            ),
            const SizedBox(height: 36),

            /* 이메일 로그인시 이메일,비밀번호 변경 탭 추가 */
            const Text(
              '내 정보',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ButtonTile(title: '이메일'),
            const SizedBox(height: 8),
            const ButtonTile(title: '비밀번호 변경'),
            const SizedBox(height: 36),

            /* 내 상태 수정하기 */
            const Text(
              '내 상태 수정하기',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const ButtonTile(title: '화구 사용 환경'),
            const SizedBox(height: 8),
            const ButtonTile(title: '내 요리 실력'),
            const SizedBox(height: 8),
            const ButtonTile(title: '알레르기 유발 식재료'),
            const SizedBox(height: 44),

            /* 로그아웃, 회원탈ㄹ퇴 */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 로그아웃
                TextButton(
                  onPressed: () => userEditViewModel.logout(),
                  child: const Text('로그아웃'),
                ),

                // Divider
                const SizedBox(
                  height: 16,
                  child: VerticalDivider(
                    color: Color(0xFFB5B5B5),
                    thickness: 0.5,
                    width: 40,
                  ),
                ),

                // 회원탈퇴
                TextButton(
                  onPressed: () => {},
                  child: const Text('회원탈퇴'),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
