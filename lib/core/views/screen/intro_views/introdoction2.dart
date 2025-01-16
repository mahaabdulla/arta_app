import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/screen/intro_views/sheard_scafoold.dart';
import 'package:flutter/material.dart';

class Introdoction2View extends StatelessWidget {
  const Introdoction2View({super.key});

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
          const SizedBox(height: 20),
          const Text(
            'بيـع بسهـولة',
            style: TextStyles.headLine1,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'قم بإضافة إعلانك بسهولة واجذب المشـترين',
              style: TextStyles.regulerHeadline,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ));
  }
}
