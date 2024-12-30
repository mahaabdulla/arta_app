import 'package:arta_app/core/constants/svg_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(screenHeight * 0.25), 
        child: SvgPicture.asset(
          topIntersect,
          fit: BoxFit.cover,
          width: screenWidth,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/png_images/Rectangle 85.png',
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.2,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'تطبيق عرطة',
                  style: TextStyle(
                    fontSize:
                        screenHeight * 0.03, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: SvgPicture.asset(
        'assets/svg_images/Intersect 2-2.svg',
        fit: BoxFit.cover,
        width: screenWidth,
        height: screenHeight * 0.1, 
      ),
    );
  }
}
