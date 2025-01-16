import 'package:arta_app/core/constants/text.dart';
import 'package:flutter/material.dart';

class CateguryList extends StatelessWidget {
  const CateguryList({
    super.key,
    required this.categ,
  });

  final List<Map<String, String>> categ;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, categ[index]['onTap']!);
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      categ[index]['image']!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    categ[index]['title']!,
                    style: TextStyles.reguler14.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
          childCount: categ.length,
        ),
      ),
    );
  }
}
