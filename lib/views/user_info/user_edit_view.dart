import 'package:flutter/material.dart';
import 'package:nutripic/components/common/main_button.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/user_info/linked_providers.dart';
import 'package:nutripic/utils/enums/login_type.dart';
import 'package:nutripic/utils/enums/main_button_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/user_info/user_edit_view_model.dart';
import 'package:provider/provider.dart';

class UserEditView extends StatelessWidget {
  const UserEditView({super.key});

  @override
  Widget build(BuildContext context) {
    UserEditViewModel userEditViewModel = context.watch<UserEditViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(title: '프로필'),
      isLoading: userEditViewModel.isLoading,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 36),
          /* 닉네임 수정 */
          Text(
            '닉네임',
            style: Palette.subtitle1SemiBold.copyWith(color: Palette.gray900),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextField(
                  controller: userEditViewModel.controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.gray50,
                    // 선택되지 않았을 때 border
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: Palette.gray100),
                    ),
                    // Focus 상태 border
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: Palette.green400),
                    ),
                    // 선택되지 않았을 때 validation 에러 border
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: Palette.delete),
                    ),
                    // Focus 상태 validation 에러 border
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: Palette.delete),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 13,
                    ),
                  ),
                  cursorColor: Palette.green400,
                  style: Palette.body1.copyWith(color: Palette.gray900),
                  textInputAction: TextInputAction.done,
                  onChanged: userEditViewModel.onChanged,
                ),
              ),
              const SizedBox(width: 8),

              // 확인 버튼
              MainButton(
                label: '확인',
                width: 68,
                height: 50,
                type: userEditViewModel.isConfirmBtnEnabled
                    ? MainButtonType.enabled
                    : MainButtonType.disabled,
                onPressed: userEditViewModel.changeNickname,
              )
            ],
          ),
          if (userEditViewModel.showErrorText)
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                '닉네임은 2자 이상 입력해야 합니다.',
                style: Palette.caption3.copyWith(color: Palette.delete),
              ),
            ),
          const SizedBox(height: 24),

          /* 연결된 계정 */
          Text(
            '연결된 계정',
            style: Palette.subtitle1SemiBold.copyWith(color: Palette.gray900),
          ),
          const SizedBox(height: 12),

          LinkedProviders(loginType: userEditViewModel.userModel.loginType!),
          const SizedBox(height: 48),

          /* 닉네임 */
          // const Text(
          //   '닉네임',
          //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          // ),
          // const SizedBox(height: 8),

          // const SizedBox(height: 36),

          /* 이메일, 비밀번호 변경 탭 */
          Text(
            '내 정보',
            style: Palette.subtitle1SemiBold.copyWith(color: Palette.gray900),
          ),
          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            // height: 108,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Palette.gray200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 이메일
                SizedBox(
                  height: 52,
                  child: Row(
                    children: [
                      Text(
                        '이메일',
                        style: Palette.body2.copyWith(color: Palette.gray900),
                      ),
                      const Spacer(),

                      // 이메일
                      Text(
                        userEditViewModel.userModel.email ?? '',
                        style: Palette.body2.copyWith(color: Palette.gray400),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),

                if (userEditViewModel.userModel.loginType == LoginType.email)
                  const Divider(
                    color: Palette.gray200,
                    thickness: 0.5,
                    height: 3,
                  ),

                if (userEditViewModel.userModel.loginType == LoginType.email)
                  // 비밀번호 변경
                  SizedBox(
                    height: 52,
                    child: Row(
                      children: [
                        Text('비밀번호 변경',
                            style:
                                Palette.body2.copyWith(color: Palette.gray900)),
                        const Spacer(),

                        Text(
                          '새로운 비밀번호로 변경하기',
                          style: Palette.body2.copyWith(color: Palette.gray400),
                        ),
                        const SizedBox(width: 20),

                        // 화살표 아이콘
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Palette.gray900,
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          /* 내 상태 수정하기 */
          // Text(
          //   '내 상태 수정하기',
          //   style: Palette.subtitle1SemiBold.copyWith(color: Palette.gray900),
          // ),
          // const SizedBox(height: 12),

          // const ButtonTile(title: '알레르기 유발 식품'),
          const Spacer(),

          /* 로그아웃, 회원탈퇴 */
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 로그아웃
              TextButton(
                onPressed: userEditViewModel.logout,
                child: const Text('로그아웃'),
              ),

              // Divider
              const SizedBox(
                height: 12,
                child: VerticalDivider(
                  color: Palette.gray200,
                  thickness: 0.5,
                  width: 12,
                ),
              ),

              // 회원탈퇴
              TextButton(
                onPressed: userEditViewModel.deleteUser,
                child: const Text('회원탈퇴'),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
