import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/screen/intro_views/sheard_scafoold.dart';
import 'package:flutter/material.dart';

class Introdoction3View extends StatelessWidget {
  const Introdoction3View({super.key});

  @override
  Widget build(BuildContext context) {
    return SheardScafoold(
        widgets: Center(
      child: Column(
        children: [
          Stack(children: [
            Image.asset(
              'assets/png_images/Vector (1).png',
              width: 200,
            ),
            Image.asset(
              'assets/png_images/Purchase online (1).png',
              width: 200,
            ),
          ]),
          const SizedBox(height: 20),
          const Text(
            'تصفح فئاتنا المتنوعة',
            style: TextStyles.headLine1,
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'من الالكترونيات إلى الاثاث لدينا كل ماتبحث عنه',
              style: TextStyles.regulerHeadline,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ));
  }
}
