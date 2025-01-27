import 'package:flutter/material.dart';
import 'package:nutripic/utils/enums/text_field_type.dart';
import 'package:nutripic/utils/palette.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final GlobalKey<FormState>? formKey;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextFieldType? textFieldType;
  const CustomTextField({
    super.key,
    this.label,
    this.controller,
    this.formKey,
    this.validator,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.textFieldType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // 텍스트 필드 외 밖 영역 탭하면 focus 해제
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      widget.formKey?.currentState?.validate();
    }
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  // suffix icon
  Widget? suffixIcon() {
    switch (widget.textFieldType) {
      case TextFieldType.email:
        return null;
      case TextFieldType.password:
        return ExcludeFocus(
          child: IconButton(
            onPressed: () {
              setState(() => _isObscure = !_isObscure);
            },
            icon: Icon(
              _isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 24,
              color: Palette.gray200,
            ),
          ),
        );
      case TextFieldType.text:
        return ExcludeFocus(
          child: IconButton(
            onPressed: () {
              setState(() => widget.controller?.clear());
            },
            icon: const Icon(Icons.cancel_outlined, size: 24),
          ),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Palette.gray900),
        // 선택되지 않았을 때 border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Palette.gray100),
        ),
        // Focus 상태 border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Palette.green600),
        ),
        // 선택되지 않았을 때 validation 에러 border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Palette.delete),
        ),
        // Focus 상태 validation 에러 border
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Palette.delete),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        suffixIcon: suffixIcon(),
      ),
      cursorColor: Palette.green500,
      style: Palette.body1.copyWith(color: Palette.gray900),
      obscureText:
          widget.textFieldType == TextFieldType.password ? _isObscure : false,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
    );
  }
}
