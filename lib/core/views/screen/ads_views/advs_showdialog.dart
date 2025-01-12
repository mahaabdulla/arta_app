import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';

class AdvsShowdialog extends StatefulWidget {
  const AdvsShowdialog({super.key});

  @override
  State<AdvsShowdialog> createState() => _AdvsShowdialogState();
}

class _AdvsShowdialogState extends State<AdvsShowdialog> {
  bool isButtomPress = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isButtomPress = !isButtomPress;
            });
          },
          child: Container(
            width: 120,
            height: 55,
            decoration: BoxDecoration(
              color: isButtomPress
                  ? Color(0xff97282A)
                  : Color.fromARGB(255, 180, 177, 177),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'ازالة الاعلان',
                style: TextStyles.smallReguler.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        //
        InkWell(
          onTap: () {
            setState(() {
              isButtomPress = !isButtomPress;
            });
          },
          child: Container(
            width: 120,
            height: 55,
            decoration: BoxDecoration(
              color: isButtomPress
                  ? Color.fromARGB(255, 180, 177, 177)
                  : Color(0xff97282A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'الغاء',
                style: TextStyles.smallReguler.copyWith(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
