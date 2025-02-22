import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/common/custom_app_bar.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/common/custom_single_child_scroll_view.dart';
import 'package:nutripic/components/common/main_button.dart';
import 'package:nutripic/components/common/custom_text_field.dart';
import 'package:nutripic/utils/enums/main_button_type.dart';
import 'package:nutripic/utils/enums/text_field_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/login/email_view_model.dart';
import 'package:provider/provider.dart';

class EmailView extends StatelessWidget {
  const EmailView({super.key});

  @override
  Widget build(BuildContext context) {
    EmailViewModel emailViewModel = context.watch<EmailViewModel>();

    return CustomScaffold(
      appBar: const CustomAppBar(
        title: '다른 방법으로 로그인',
        centerTitle: false,
      ),
      resizeToAvoidBottomInset: true,
      isLoading: emailViewModel.isLoading,
      body: Form(
        key: emailViewModel.formKey,
        autovalidateMode: emailViewModel.validateMode,
        child: CustomSingleChildScrollView(
          children: [
            SizedBox(height: emailViewModel.topPadding()),

            // 로고
            Container(
              margin: const EdgeInsets.all(20),
              child: SvgPicture.asset(
                'assets/icons/nutripic_logo_primary.svg',
                width: 90,
                height: 90,
              ),
            ),
            const SizedBox(height: 15),

            // 뉴트리픽
            SvgPicture.asset(
              'assets/icons/nutripic_text_primary.svg',
              width: 213,
              height: 51,
            ),
            const SizedBox(height: 35),

            // 이메일
            CustomTextField(
              label: '이메일',
              controller: emailViewModel.email,
              validator: emailViewModel.validateEmail,
              onChanged: emailViewModel.onTextFieldChanged(),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textFieldType: TextFieldType.email,
            ),
            const SizedBox(height: 20),

            // 비밀번호
            CustomTextField(
              label: '비밀번호',
              controller: emailViewModel.password,
              validator: emailViewModel.validatePassword,
              onChanged: emailViewModel.onTextFieldChanged(),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textFieldType: TextFieldType.password,
            ),

            if (emailViewModel.errorText != null)
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  emailViewModel.errorText!,
                  style: Palette.subbody1.copyWith(color: Palette.delete),
                ),
              ),
            const SizedBox(height: 20),
            const Spacer(),

            // 로그인 버튼
            MainButton(
              label: '로그인',
              type: emailViewModel.isLoginBtnEnabled
                  ? MainButtonType.enabled
                  : MainButtonType.disabled,
              onPressed: emailViewModel.emailLogin,
            ),
          ],
        ),
      ),
    );
  }
}
