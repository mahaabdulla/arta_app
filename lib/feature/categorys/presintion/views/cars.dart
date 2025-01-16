import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/ads/presition/widgets/advs_card_info.dart';
import 'package:flutter/material.dart';

class CarsView extends StatelessWidget {
  const CarsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Color(0xff428F90),
          centerTitle: true,
          title: Text('السيارات',
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
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEifloAkObvx-7e79RpxI2fOoM9mjchEXLlmQ5yGx4Iav_0XbmHfR0JeQk4fHPD-j1tH_giwS-6-kqpdP0U2or939OcHcaza2xYUfoeAvPBKi1rjdBLE_1lq2T_CPVO54QVhvOH33z-IoTkFmHf2oQ-gopWTfNa-auDk9ugZrW_uxOM8pmUUhm6qf7EUvFq-/w640-h480/WhatsApp%20Image%202024-02-05%20at%2010.48.10%20AM%20(1).jpeg'),
                                    fit: BoxFit.cover)),
                          )),
                      Expanded(
                        child: AdvsCardInfo(
                          title: 'سيارة توياوتا نوديل 2017',
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
