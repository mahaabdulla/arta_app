import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/svg_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/ads/presition/widgets/advertisements.dart';
import 'package:arta_app/core/views/widgets/catgury_list.dart';
import 'package:arta_app/feature/home/presention/widgets/searchbar.dart';
import 'package:arta_app/feature/home/presention/widgets/categury_list.dart';
import 'package:arta_app/feature/home/presention/widgets/see_more_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  final List<Map<String, String>> categ = [
    {'image': cars, 'title': 'السيارات', 'onTap': '/cars'},
    {'image': motors, 'title': 'الدراجات', 'onTap': '/motors'},
    {'image': electronic, 'title': 'الإلكترونيات', 'onTap': '/electronic'},
    {'image': home, 'title': 'المنزل', 'onTap': '/homeCatg'},
    {'image': sports, 'title': 'الرياضة', 'onTap': '/sport'},
    {'image': clothing, 'title': 'الملابس النسائية', 'onTap': '/women'},
    {'image': ecomiric, 'title': 'عقارات', 'onTap': '/real_estate'},
    {'image': more, 'title': 'المزيد', 'onTap': '/more'},
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
            // الاعلانات
            const Positioned(child: AdvertisementsView())
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // العنوان "الفئات"
          SliverPadding(
              padding: const EdgeInsets.only(right: 30.0),
              sliver: SliverToBoxAdapter(
                  child: Text(
                'الفئات',
                style:
                    TextStyles.medium24.copyWith(fontWeight: FontWeight.bold),
              ))),
          //
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          //  العناصر
          CateguryList(categ: categ),
          // شريط البحث وزر الفلتر
          const SliverToBoxAdapter(child: SearchBarFiltter()),
          // قائمة المنتجات
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
          // زر مشاهدة المزيد
          SeeMoreButtom(),
        ],
      ),
    );
    ;
  }
}

