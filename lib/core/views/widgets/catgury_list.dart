import 'package:arta_app/core/constants/colors.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/widgets/details_bottum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CatguryList extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String title;
  final String text;
  final String userName;
  final String time;
  final String price;
  final String location;
  final String imagePath;

  CatguryList({
    super.key,
    required this.onTap,
    required this.color,
    required this.title,
    required this.text,
    required this.userName,
    required this.time,
    required this.price,
    required this.location,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة العنصر
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imagePath,
                          width: 100,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 15),
                      // تفاصيل العنصر
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // اسم العنصر
                            Text(
                              title,
                              style: TextStyles.reguler14.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // صف: اسم البائع و المدينة
                            Row(
                              children: [
                                // اسم البائع
                                Row(
                                  children: [
                                    SvgPicture.asset(userImage),
                                    const SizedBox(width: 4),
                                    Text(userName,
                                        style: TextStyles.reguler14.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: darkBlck)),
                                  ],
                                ),
                                SizedBox(width: 60),
                                // المدينة
                                Row(
                                  children: [
                                    SvgPicture.asset(locationImage),
                                    const SizedBox(width: 4),
                                    Text(location,
                                        style: TextStyles.reguler14.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: darkBlck)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(clockImage),
                                const SizedBox(width: 4),
                                Text(time,
                                    style: TextStyles.reguler14.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: darkBlck)),
                                SizedBox(width: 75),
                                // السعر
                                SvgPicture.asset(dollerImage),
                                Text(price,
                                    style: TextStyles.reguler14.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: darkBlck)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // زر عرض التفاصيل
                  DetailsBottum(
                    onTap: onTap,
                    color: color,
                    text: 'عرض التفاصيل',
                    imagePath: 'assets/svg_images/Arrow Left.svg',
                  ),
                ],
              ),
            ),
          );
        },
        childCount: 7,
      ),
    );
  }
}
