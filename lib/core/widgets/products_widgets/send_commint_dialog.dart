import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SendCommintDialog extends StatelessWidget {
  VoidCallback onTap;
  SendCommintDialog({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset('assets/svg_images/closeIcon.svg'),
        ),
      ),
      content: TextField(
        maxLines: 8,
        decoration: InputDecoration(
          hintText: 'يرجى كتابة سبب الابلاغ...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      actions: [
        Center(
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'إبلاغ المشرف',
                  style: TextStyles.smallReguler.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
