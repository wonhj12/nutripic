import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutripic/components/common/custom_scaffold.dart';
import 'package:nutripic/components/main_button.dart';
import 'package:nutripic/components/custom_text_field.dart';
import 'package:nutripic/utils/enums/text_field_type.dart';
import 'package:nutripic/utils/palette.dart';
import 'package:nutripic/view_models/login/email_view_model.dart';
import 'package:provider/provider.dart';

class EmailView extends StatefulWidget {
  const EmailView({super.key});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  @override
  Widget build(BuildContext context) {
    EmailViewModel emailViewModel = context.watch<EmailViewModel>();

    return CustomScaffold(
      resizeToAvoidBottomInset: true,
      isLoading: emailViewModel.isLoading,
      body: Form(
        key: emailViewModel.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: emailViewModel.topPadding()),

              // 로고
              Container(
                margin: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  'assets/icons/logo_no_bg.svg',
                  width: 64,
                  height: 64,
                ),
              ),
              const SizedBox(height: 15),

              // 뉴트리픽
              SvgPicture.asset(
                'assets/icons/nutripic.svg',
                width: 194,
                height: 52,
              ),
              const SizedBox(height: 158),

              // 이메일
              CustomTextField(
                label: '이메일',
                controller: emailViewModel.email,
                validator: emailViewModel.validateEmail(),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                textFieldType: TextFieldType.email,
              ),
              const SizedBox(height: 20),

              // 비밀번호
              CustomTextField(
                label: '비밀번호',
                controller: emailViewModel.password,
                validator: emailViewModel.validatePassword(),
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
              const SizedBox(height: 60),

              // 로그인 버튼
              MainButton(
                label: '로그인',
                onPressed: emailViewModel.emailLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
