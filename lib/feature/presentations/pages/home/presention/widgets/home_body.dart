import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/advertisements.dart';
import 'package:arta_app/core/widgets/products_list.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/searchbar.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/categury_list.dart';
import 'package:arta_app/feature/presentations/pages/home/presention/widgets/see_more_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  // final List<Category> categories = [
  //   Category(
  //     id: 1,
  //     name: 'السيارات',
  //   ),
  //   Category(
  //     id: 2,
  //     name: 'الدراجات',
  //   ),
  //   Category(
  //     id: 54,
  //     name: 'الأجهزة',
  //   ),
  //   Category(
  //     id: 92,
  //     name: 'الأثاث',
  //   ),
  //   Category(
  //     id: 5,
  //     name: 'الرياضة',
  //   ),
  //   Category(
  //     id: 6,
  //     name: 'الملابس النسائية',
  //   ),
  //   Category(
  //     id: 26,
  //     name: 'عقارات',
  //   ),
  //   Category(
  //     id: 8,
  //     name: 'المزيد',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(280),
        child: Stack(
          children: [
            SvgPicture.asset(
              group1,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            const Positioned(child: AdvertisementsView()),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'الفئات',
                style:
                    TextStyles.medium24.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CategoryList(),
              const SizedBox(height: 16),
              SearchBarFiltter(),
              ProductsList(),
              const SizedBox(height: 16),
              SeeMoreButtom(),
            ],
          ),
        ),
      ),
    );
  }
}
