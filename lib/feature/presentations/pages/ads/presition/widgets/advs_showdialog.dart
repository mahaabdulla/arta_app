import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';

class AdvsShowdialog extends StatefulWidget {
  const AdvsShowdialog({super.key});

  @override
  State<AdvsShowdialog> createState() => _AdvsShowdialogState();
}

class _AdvsShowdialogState extends State<AdvsShowdialog> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AdvButton(
          text: 'ازالة الاعلان',
          isPressed: isButtonPressed,
          onTap: () {
            setState(() {
              isButtonPressed = !isButtonPressed;
            });
          },
        ),
        SizedBox(width: 10),
        AdvButton(
          text: 'الغاء',
          isPressed: !isButtonPressed,
          onTap: () {
            setState(() {
              isButtonPressed = !isButtonPressed;
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}

class AdvButton extends StatelessWidget {
  final String text;
  final bool isPressed;
  final VoidCallback onTap;

  const AdvButton({
    required this.text,
    required this.isPressed,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 55,
        decoration: BoxDecoration(
          color: isPressed
              ? Color(0xff97282A)
              : Color.fromARGB(255, 180, 177, 177),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyles.smallReguler.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
