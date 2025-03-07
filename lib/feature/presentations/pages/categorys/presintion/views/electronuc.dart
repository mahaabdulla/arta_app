import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/presentations/pages/ads/presition/widgets/advs_card_info.dart';
import 'package:flutter/material.dart';

class ElectronicView extends StatelessWidget {
  const ElectronicView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Color(0xff428F90),
          centerTitle: true,
          title: Text('الالكترونيات',
              style: TextStyles.regulerHeadline
                  .copyWith(fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
        body: SizedBox(
          child: ListView.builder(itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 110,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://d26e3f10zvrezp.cloudfront.net/Gallery/d98448ca-1eef-43f3-a404-32f2b41518b7-1024x1024.webp'),
                                    fit: BoxFit.cover)),
                          )),
                      Expanded(
                        child: AdvsCardInfo(
                          title: 'لابتوب ديل ',
                          location: 'المكان',
                          userName: 'حسين عبدالله',
                          time: '20 دقيقة',
                          price: '20.000 ر.ي',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
