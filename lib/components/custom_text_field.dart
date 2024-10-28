import 'package:flutter/material.dart';
import 'package:nutripic/utils/palette.dart';

enum TextFieldType { email, password, text }

class CustomTextField extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final GlobalKey<FormState>? formKey;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextFieldType? textFieldType;
  const CustomTextField({
    super.key,
    this.label,
    this.controller,
    this.formKey,
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
        labelStyle: _focusNode.hasFocus
            ? const TextStyle(color: Palette.sub)
            : const TextStyle(color: Palette.black),
        // 선택되지 않았을 때 border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Palette.gray100),
        ),
        // Focus 상태 border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 1, color: Palette.sub),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        suffixIcon: suffixIcon(),
      ),
      cursorColor: Palette.sub,
      style: Palette.body.copyWith(color: Palette.black),
      obscureText:
          widget.textFieldType == TextFieldType.password ? _isObscure : false,
      textInputAction: widget.textInputAction,
    );
  }
}
