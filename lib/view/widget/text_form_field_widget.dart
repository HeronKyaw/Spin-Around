import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? text;
  final TextEditingController controller;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? shffixWidget;
  final bool? obscureText;
  const TextFormFieldWidget({
    super.key,
    this.text,
    required this.controller,
    this.readOnly,
    this.validator,
    this.textInputType,
    required this.labelText,
    this.prefixIcon,
    this.shffixWidget,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text == null
            ? Container()
            : Text(
                text!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: textInputType ?? TextInputType.name,
          readOnly: readOnly ?? false,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              fillColor: const Color(0xFFD9D9D9),
              filled: true,
              isDense: true,
              errorStyle: const TextStyle(color: Colors.red),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              hintText: labelText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              labelStyle: const TextStyle(
                color: Color(0xFFB4A9A7),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: shffixWidget,
              enabledBorder: outlineInputBorderDesign(),
              border: outlineInputBorderDesign()),
        ),
      ],
    );
  }

  OutlineInputBorder outlineInputBorderDesign() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    );
  }
}
