import 'package:flutter/material.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/custom_single_child_scroll_view.dart';
import 'package:nutripic/components/custom_text_field.dart';
import 'package:nutripic/components/main_button.dart';
import 'package:nutripic/utils/enums/main_button_type.dart';
import 'package:nutripic/utils/enums/text_field_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/login/signup_view_model.dart';
import 'package:provider/provider.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    SignupViewModel signupViewModel = context.watch<SignupViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(title: '회원가입'),
      resizeToAvoidBottomInset: true,
      isLoading: signupViewModel.isLoading,
      body: Form(
        key: signupViewModel.formKey,
        autovalidateMode: signupViewModel.validateMode,
        child: CustomSingleChildScrollView(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 52),

            // 이름
            CustomTextField(
              label: '이름',
              controller: signupViewModel.name,
              validator: signupViewModel.validateName,
              onChanged: signupViewModel.onTextFieldChanged(),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textFieldType: TextFieldType.text,
            ),
            const SizedBox(height: 24),

            // 이메일
            CustomTextField(
              label: '이메일',
              controller: signupViewModel.email,
              validator: signupViewModel.validateEmail,
              onChanged: signupViewModel.onTextFieldChanged(),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textFieldType: TextFieldType.email,
            ),
            const SizedBox(height: 24),

            // 비밀번호
            CustomTextField(
              label: '비밀번호',
              controller: signupViewModel.password,
              validator: signupViewModel.validatePassword,
              onChanged: signupViewModel.onTextFieldChanged(),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textFieldType: TextFieldType.password,
            ),
            const SizedBox(height: 8),

            // 비밀번호 도움 문구
            Text(
              '비밀번호는 최소 8자로 구성해야하며,\n특수문자, 숫자, 영어 중 2개 이상의 조건을 충족해야합니다.',
              style: Palette.caption3.copyWith(color: Palette.gray400),
            ),
            const SizedBox(height: 24),

            // 비밀번호 확인
            CustomTextField(
              label: '비밀번호 확인',
              controller: signupViewModel.passwordCheck,
              validator: signupViewModel.validatePasswordCheck,
              onChanged: signupViewModel.onTextFieldChanged(),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textFieldType: TextFieldType.password,
            ),

            // 오류 문구
            if (signupViewModel.errorText != null)
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  signupViewModel.errorText!,
                  style: Palette.subbody1.copyWith(color: Palette.delete),
                ),
              ),
            const SizedBox(height: 24),
            const Spacer(),

            // 회원가입
            MainButton(
              label: '회원가입',
              type: signupViewModel.isSignupBtnEnabled
                  ? MainButtonType.enabled
                  : MainButtonType.disabled,
              onPressed: signupViewModel.signup,
            ),
          ],
        ),
      ),
    );
  }
}
