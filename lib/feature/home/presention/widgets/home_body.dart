
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/ads/presition/widgets/advertisements.dart';
import 'package:arta_app/core/views/widgets/catgury_list.dart';
import 'package:arta_app/feature/home/presention/widgets/searchbar.dart';
import 'package:arta_app/feature/home/presention/widgets/categury_list.dart';
import 'package:arta_app/feature/home/presention/widgets/see_more_buttom.dart';
import 'package:arta_app/feature/categorys/data/categury_model.dart'; // Import Category model
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  final List<Category> categories = [
    Category(
      id: 1,
      name: 'السيارات',
    ),
    Category(
      id: 2,
      name: 'الدراجات',
    ),
    Category(
      id: 54,
      name: 'الأجهزة',
    ),
    Category(
      id: 92,
      name: 'الأثاث',
    ),
    Category(
      id: 5,
      name: 'الرياضة',
    ),
    Category(
      id: 6,
      name: 'الملابس النسائية',
    ),
    Category(
      id: 26,
      name: 'عقارات',
    ),
    Category(
      id: 8,
      name: 'المزيد',
    ),
  ];

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
            const Positioned(child: AdvertisementsView())
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
              padding: const EdgeInsets.only(right: 30.0),
              sliver: SliverToBoxAdapter(
                  child: Text(
                'الفئات',
                style:
                    TextStyles.medium24.copyWith(fontWeight: FontWeight.bold),
              ))),
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          CateguryList(categ: categories), 
          const SliverToBoxAdapter(child: SearchBarFiltter()),
          CatguryList(
            color: const Color(0xff046998),
            title: 'سيارة تويوتا موديل 2006',
            text: '',
            userName: 'أحمد',
            time: '30',
            price: '30.000',
            location: 'سيئون',
            imagePath:
                'https://cp.slaati.com//wp-content/uploads/2024/04/WhatsApp-Image-2024-04-09-at-12.52.56-PM.jpeg',
            onTap: () {
              Navigator.pushNamed(context, '/product');
            },
          ),
          SeeMoreButtom(),
        ],
      ),
    );
  }
}
