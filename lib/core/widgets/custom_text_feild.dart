import 'package:arta_app/core/utils/global_methods/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool isPassword;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final bool? readOnly;
  final Function(String)? onChanged;
  final TextEditingController? compareWith;
  final String? Function(String?)? customValidator;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.label,
    this.isPassword = false,
    this.compareWith,
    this.customValidator,
    this.focusNode,
    this.onChanged,
    this.readOnly,
    this.suffixIcon,
    this.hintText,
    this.maxLines,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: TextStyles.medium18
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        hSpace(20.h),
        TextFormField(
          maxLines: widget.maxLines ?? 1,
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.isPassword ? _isObscure : false,
          decoration: InputDecoration(
            // labelText: widget.label,
            hintText: widget.hintText,
            hintStyle: TextStyles.reguler14
                .copyWith(fontWeight: FontWeight.normal, color: Colors.black54),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : widget.suffixIcon ?? null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: Colors.teal),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: Colors.teal, width: 2.w),
            ),
          ),
          onChanged: widget.onChanged,
          readOnly: widget.readOnly ?? false,
          validator: widget.customValidator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return "يرجى إدخال ${widget.label}";
                }
                if (widget.label == "تأكيد كلمة المرور" &&
                    widget.compareWith != null &&
                    value != widget.compareWith!.text) {
                  return "كلمات المرور غير متطابقة";
                }
                return null;
              },
        ),
      ],
    );
  }
}
