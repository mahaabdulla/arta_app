import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BlueContainerWidget extends StatelessWidget {
  final String text;
  final String? imagePath;
  final VoidCallback onTap;

  BlueContainerWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 40,
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
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              (imagePath != null)
                  ? SvgPicture.asset(
                      imagePath!,
                      height: 20,
                      width: 20,
                    )
                  : const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Color(0xff003047),
                      size: 24,
                    ),
              const SizedBox(width: 20),
              Text(
                text,
                style: TextStyles.smallReguler
                    .copyWith(color: darkBlur, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
