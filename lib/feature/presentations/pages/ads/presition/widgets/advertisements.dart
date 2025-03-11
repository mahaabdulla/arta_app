import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../cubits/ads/ads_cubit.dart';
import '../../../../cubits/ads/ads_state.dart';

// Ads Slider

class AdvertisementsView extends StatefulWidget {
  const AdvertisementsView({super.key});

  @override
  State<AdvertisementsView> createState() => _AdvertisementsViewState();
}

class _AdvertisementsViewState extends State<AdvertisementsView> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // final List<Map<String, String>> ads = [
    //   {
    //     'title': 'هل لديك منتج للبيع',
    //     'description':
    //         'إبدا رحلتك في منصة عرطة وانشر إعلانك مجاناً وحقق أرباحك. لا تفوت الفرصة!',
    //     'imagePath': 'assets/png_images/adv.png',
    //   },
    //   {
    //     'title': 'اعلن عن خدماتك الآن',
    //     'description': 'انشر إعلانك الخاص بالخدمات لتحقيق المزيد من الأرباح.',
    //     'imagePath': 'assets/png_images/adv.png',
    //   },
    //   {
    //     'title': 'فرصتك لبيع المنتجات!',
    //     'description': 'استفد من منصة عرطة للوصول إلى آلاف العملاء.',
    //     'imagePath': 'assets/png_images/adv.png',
    //   },
    // ];

    return BlocBuilder<AdsCubit, AdsState>(
      builder: (context, state) {
      if (state is LoadingAdsState) {
        return Center(child: CircularProgressIndicator());
      } else if (state is SuccessAdsState) {
        if (state.ads.data == null || state.ads.data!.isEmpty) {
          return Center(child: Text("لا توجد إعلانات متاحة"));
        }else{
          return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider.builder(
                itemCount: state.ads.links!.length,
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  //  final ad = state.ads;
                  //  [index];
                  // final ad = ads[index];
                  return _buildAdContainer(
                    title:state.ads.links?[index].label?? "",
                    description: "",
                    //الصورة لما تكون حقيقية المفروض نجيبها من ملف مش رابط
                    //لأنها ترفع في السيرفر على شكل ملف 
                    imagePath: state.ads.links?[index].url ?? "imagePath': 'assets/png_images/adv.png" ,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            AnimatedSmoothIndicator(
              activeIndex: _currentPage,
              count: state.ads.links!.length,
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
      }
       return SizedBox();
    });
  }

  Widget _buildAdContainer({
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: TextStyles.mediumHeadline.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      description,
                      style: TextStyles.reguler14.copyWith(fontSize: 12),
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/add_advr');
                      },
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
          ),
          const SizedBox(width: 12),
          Container(
            width: MediaQuery.of(context).size.width * 0.30,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
