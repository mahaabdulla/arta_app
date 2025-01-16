import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/screen/intro_views/sheard_scafoold.dart';
import 'package:flutter/material.dart';

class Introdoction1 extends StatelessWidget {
  const Introdoction1({super.key});

  @override
  Widget build(BuildContext context) {
    return SheardScafoold(
        widgets: Center(
      child: Column(
        children: [
          Stack(children: [
            Image.asset(
              onBordingBackgoung,
              width: 200,
            ),
            Image.asset(
              onBordingImage,
              width: 200,
            ),
          ]),
          const SizedBox(height: 30),
          const Text(
            'مرحبًا بك في عرطة',
            style: TextStyles.headLine1,
          ),
          const Text(
            'اكتشف عالم الشراء و البيع بسهولة ',
            style: TextStyles.regulerHeadline,
          ),
        ],
      ),
    ));
  }
}
