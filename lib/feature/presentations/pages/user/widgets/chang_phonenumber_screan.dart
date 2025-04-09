import 'package:arta_app/feature/presentations/pages/user/widgets/profile_scafoold.dart';
import 'package:flutter/material.dart';

class ChangPhoneNumberScrean extends StatelessWidget {
  const ChangPhoneNumberScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScaffold(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("data"),
        Container(
          width: 358,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xffD6D6D6), width: 1),
          ),
        ),
        Text("data"),
        Text("data"),
      ],
    ));
  }
}
