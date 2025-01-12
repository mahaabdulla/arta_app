import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasicScaffold extends StatelessWidget {
  final Widget widgets;
  final VoidCallback? onTap;
  final String? title;
  final String? text;
  final bool showBackButton;

  BasicScaffold({
    super.key,
    required this.widgets,
    this.title,
    this.text,
    this.onTap,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.34),
        child: Stack(
          children: [
            // background
            SvgPicture.asset(
              group1,
              fit: BoxFit.cover,
              width: screenWidth,
              height: screenHeight * 0.5,
            ),

            if (showBackButton)
              Positioned(
                top: screenHeight * 0.11,
                right: screenWidth * 0.09,
                child: Row(
                  children: [
                    InkWell(
                      onTap: onTap,
                      child: SvgPicture.asset(
                        iconsArrow,
                      ),
                    ),
                    SizedBox(width: 30),
                    if (title != null)
                      Text(
                        title!,
                        style: TextStyles.medium24.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
      body: widgets,
    );
  }
}
