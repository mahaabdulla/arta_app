import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CatguryList extends StatelessWidget {
  final VoidCallback onTap;
   CatguryList({super.key,
   required this.onTap
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
                          'https://cp.slaati.com//wp-content/uploads/2024/04/WhatsApp-Image-2024-04-09-at-12.52.56-PM.jpeg',
                          width: 80,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // تفاصيل العنصر
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // اسم العنصر
                            Text(
                              'سيارة تويوتا موديل 2006',
                              style: TextStyles.reguler14.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // صف: اسم البائع و المدينة
                            Row(
                              children: [
                                // اسم البائع
                                Row(
                                  children: [
                                    SvgPicture.asset(userImage),
                                    const SizedBox(width: 4),
                                    Text('اسم البائع',
                                        style: TextStyles.reguler14.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                                SizedBox(width: 60),
                                // المدينة
                                Row(
                                  children: [
                                    SvgPicture.asset(locationImage),
                                    const SizedBox(width: 4),
                                    Text('الرياض',
                                        style: TextStyles.reguler14.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(clockImage),
                                    const SizedBox(width: 4),
                                    Text('38 دقيقة',
                                        style: TextStyles.reguler14.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                  ],
                                ),
                                // السعر
                                Row(
                                  children: [
                                    SvgPicture.asset(dollerImage),
                                    const SizedBox(width: 4),
                                    Text('45,000 ريال',
                                        style: TextStyles.reguler14.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // زر عرض التفاصيل
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: const Color(0xff046998),
                            borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'عرض التفاصيل',
                              style: TextStyles.reguler14.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SvgPicture.asset('assets/svg_images/Arrow Left.svg')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: 7, // عدد العناصر
      ),
    );
  }
}
