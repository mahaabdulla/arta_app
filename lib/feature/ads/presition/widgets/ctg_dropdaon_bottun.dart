// Widget لإنشاء قوائم منسدلة
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const DropdownWidget({
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 116, 172, 196),
            Color.fromARGB(255, 112, 164, 158)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            items: items
                .map((e) => DropdownMenuItem(
                    child: Text(e, style: const TextStyle(fontSize: 16)),
                    value: e))
                .toList(),
            onChanged: onChanged,
            value: value,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
