// Widget لإنشاء حقول النصوص
import 'package:flutter/material.dart';

class AdsTextFieldWidget extends StatelessWidget {
   TextEditingController controller = TextEditingController();
  final String hintText;
  final int maxLines;

   AdsTextFieldWidget({
    required this.controller,
    required this.hintText,
    required this.maxLines,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 116, 172, 196),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 112, 164, 158),
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 180, 180, 180),
            width: 2,
          ),
        ),
      ),
    );
  }
}
