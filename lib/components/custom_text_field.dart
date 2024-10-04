import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final GlobalKey<FormState>? formKey;
  final String? initialValue;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    this.controller,
    this.formKey,
    this.initialValue,
    this.keyboardType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        // 선택되지 않았을 때 border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0.5, color: Color(0xFFB5B5B5)),
        ),
        // Focus 상태 border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 0.5, color: Color(0xFFB5B5B5)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.controller?.clear();
            });
          },
          icon: const Icon(Icons.cancel_outlined, size: 24),
        ),
      ),
    );
  }
}
