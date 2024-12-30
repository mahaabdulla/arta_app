import 'package:arta_app/core/constants/svg_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasicScaffold extends StatelessWidget {
  final Widget widgets;
  final VoidCallback? onTap;
  final String? title;
  final bool showBackButton;

  BasicScaffold({
    super.key,
    required this.widgets,
    this.title,
    this.onTap,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.4),
        child: Stack(
          children: [
            // الخلفية
            SvgPicture.asset(
              group1,
              fit: BoxFit.cover,
              width: screenWidth,
              height: screenHeight * 0.5,
            ),

            if (showBackButton)
              Positioned(
                top: screenHeight * 0.10,
                child: InkWell(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    iconsArrow,
                  ),
                ),
              ),

          
          ],
        ),
      ),
      body: widgets,
    );
  }
}
