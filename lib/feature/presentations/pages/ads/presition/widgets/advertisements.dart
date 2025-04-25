import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:arta_app/core/constants/text.dart';

class AdvertisementsView extends StatefulWidget {
  const AdvertisementsView({super.key});

  @override
  State<AdvertisementsView> createState() => _AdvertisementsViewState();
}

class _AdvertisementsViewState extends State<AdvertisementsView> {
  int _currentPage = 0;

  final List<Map<String, String>> ads = [
    {
      'title': 'هل لديك منتج للبيع؟',
      'description': 'إبدا رحلتك في منصة عرطة وانشر إعلانك مجاناً وحقق أرباحك!',
      'imagePath': 'assets/png_images/adv.png',
    },
    {
      'title': 'اعلن عن خدماتك الآن',
      'description': 'انشر إعلانك الخاص بالخدمات لتحقيق المزيد من الأرباح.',
      'imagePath': 'assets/png_images/adv.png',
    },
    {
      'title': 'فرصتك لبيع المنتجات!',
      'description': 'استفد من منصة عرطة للوصول إلى آلاف العملاء.',
      'imagePath': 'assets/png_images/adv.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: ads.length,
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(milliseconds: 600),
              enlargeCenterPage: true,
              viewportFraction: 0.85,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            itemBuilder: (context, index, _) {
              final ad = ads[index];
              return _buildAdContainer(
                context: context,
                title: ad['title']!,
                description: ad['description']!,
                imagePath: ad['imagePath']!,
              );
            },
          ),
          const SizedBox(height: 12),
          AnimatedSmoothIndicator(
            activeIndex: _currentPage,
            count: ads.length,
            effect: const ScrollingDotsEffect(
              activeDotColor: Color(0xff33869C),
              dotColor: Colors.grey,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdContainer({
    required BuildContext context,
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.mediumHeadline.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyles.reguler14.copyWith(fontSize: 12),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Center(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/add_advr'),
                    child: Container(
                      height: 40,
                      width: 145,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Color(0xff4C968A), Color(0xff33869C)],
                        ),
                      ),
                      child: Text(
                        'أضف إعلانك الآن',
                        style: TextStyles.reguler14.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
