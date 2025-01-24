import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SendCommintBottom extends StatelessWidget {
  const SendCommintBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
          context: context,
          builder: (ctx) {
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
                      hintText: 'يرجى كتابة سبب الابلاغ... ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)))),
              actions: [
                Center(
                  child: InkWell(
                    onTap: () {
                      // الاتصال ب api و ارسال تعليق 
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
                          style: TextStyles.smallReguler
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
      child: Container(
        width: 200,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
          color: const Color(0xff559FC1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(sendCommint),
            const SizedBox(width: 5),
            Text(
              'ارسال التعليق',
              style:
                  TextStyles.smallReguler.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
