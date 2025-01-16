import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/screen/ads_views/advs_card_info.dart';
import 'package:arta_app/core/views/screen/ads_views/advs_showdialog.dart';
import 'package:arta_app/core/views/widgets/basic_scafoold.dart';
import 'package:arta_app/core/views/widgets/details_bottum.dart';
import 'package:flutter/material.dart';

class MyAds extends StatelessWidget {
  const MyAds({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      onTap: () {
        Navigator.pushNamed(context, '/home');
      },
      title: 'إعلاناتي',
      text: 'text',
      showBackButton: true,
      widgets: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (ctx, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        imageContaner(
                          'https://d26e3f10zvrezp.cloudfront.net/Gallery/7dd4c244-5497-449d-85aa-8292517b8526-1024x1024.webp',
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AdvsCardInfo(
                            title: 'لابتوب ماركه ديل',
                            location: 'المكان',
                            userName: 'حسين عبدالله',
                            time: '20 دقيقة',
                            price: '20.000 ر.ي',
                          ),
                          // reomve item form my adv
                          DetailsBottum(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text(
                                        textAlign: TextAlign.center,
                                        'هل أنت متأكد أنك ترغب في إزالة هذا الإعلان؟',
                                        style: TextStyles.smallReguler.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        textAlign: TextAlign.center,
                                        'هذه العملية لايمكن التراجع عنها',
                                        style: TextStyles.reguler14,
                                      ),
                                      actions: [AdvsShowdialog()],
                                    );
                                  });
                              print('إزالة الإعلان');
                            },
                            color: Color(0xff97282A),
                            text: 'إزالة الإعلان',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// الكونتاينر الي بداخله الصورة
Widget imageContaner(String imageUrl) {
  return Container(
    height: 110,
    width: 100,
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 40, 40, 40)),
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.contain,
      ),
    ),
  );
}
