import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SheardScafoold extends StatelessWidget {
  final Widget widgets;

  const SheardScafoold({
    super.key,
    required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.40),
          child: Stack(
            children: [
              SvgPicture.asset(
                group1,
                fit: BoxFit.cover,
                width: screenWidth,
                height: screenHeight * 0.5,
              ),
              Positioned(
                top: 60,
                left: 25,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/png_images/Rectangle 85.png',
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.2,
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    Text(
                      'منصة عرطة',
                      style: TextStyles.mediumHeadline
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Divider
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: const Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    Text(
                      'تطبيق احترافي لأعمال البيع',
                      style:
                          TextStyles.smallReguler.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'والشراء الخاص بك',
                      style:
                          TextStyles.smallReguler.copyWith(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: widgets);
  }
}
