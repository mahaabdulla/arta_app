import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/core/views/screen/ads_views/advs_showdialog.dart';
import 'package:arta_app/core/views/widgets/basic_scafoold.dart';
import 'package:arta_app/core/views/widgets/details_bottum.dart';
import 'package:flutter/material.dart';


class AdImage extends StatelessWidget {
  final String imageUrl;

  const AdImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
}


class AdDetails extends StatelessWidget {
  final String title;
  final String location;
  final String userName;
  final String time;
  final String price;

  const AdDetails({
    required this.title,
    required this.location,
    required this.userName,
    required this.time,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.reguler14.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.place, color: Colors.grey),
            SizedBox(width: 5),
            Text(location),
            Spacer(),
            Icon(Icons.person, color: Colors.grey),
            SizedBox(width: 5),
            Text(userName),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.grey),
            SizedBox(width: 5),
            Text(time),
            Spacer(),
            Icon(Icons.attach_money, color: Colors.grey),
            SizedBox(width: 5),
            Text(price),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class MyAds extends StatelessWidget {
  const MyAds({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      title: 'إعلاناتي',
      text: 'text',
      showBackButton: true,
      widgets: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdImage(
                      imageUrl:
                          'https://imgd.aeplcdn.com/370x208/n/cw/ec/130591/fronx-exterior-right-front-three-quarter-110.jpeg?isig=0&q=80',
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AdDetails(
                            title: 'لابتوب ماركه ديل',
                            location: 'المكان',
                            userName: 'اسم المستخدم',
                            time: '20 دقيقة',
                            price: 'السعر 20.000 ر.ي',
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
