import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductsCard extends StatelessWidget {
  const ProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Column(
              children: [
                // الصورة
                Container(
                  height: screenHeight * 0.20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/png_images/cars_shop.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // اسم المنتج
                Text(
                  'سيارة تويوتا موديل 2006',
                  style: TextStyles.medium18.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // العمود الأول
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                locationImage,
                                height: screenHeight * 0.03,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              const Text(
                                'المكلاء',
                                style: TextStyles.smallReguler,
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Row(
                            children: [
                              SvgPicture.asset(
                                clockImage,
                                height: screenHeight * 0.03,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              const Text(
                                '30 دقيقة',
                                style: TextStyles.smallReguler,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // العمود الثاني
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                userImage,
                                height: screenHeight * 0.03,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              const Text(
                                'أحمد علي',
                                style: TextStyles.smallReguler,
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Row(
                            children: [
                              SvgPicture.asset(
                                dollerImage,
                                height: screenHeight * 0.03,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              const Text(
                                '300.000 ر.ي',
                                style: TextStyles.smallReguler,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 150,
              height: screenHeight * 0.05,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xffFECA81),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Text(
                'سيارات',
                style: TextStyles.smallReguler.copyWith(
                    fontWeight: FontWeight.bold, color: Color(0xff01496B)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}