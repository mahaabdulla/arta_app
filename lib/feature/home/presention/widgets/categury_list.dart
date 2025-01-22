import 'package:arta_app/core/constants/png_images.dart';
import 'package:arta_app/core/constants/text.dart';
import 'package:arta_app/feature/categorys/presintion/ctagurey_children_view.dart';
import 'package:flutter/material.dart';
import 'package:arta_app/feature/categorys/data/categury_model.dart';

class CateguryList extends StatelessWidget {
  final List<Category> categ;

   CateguryList({
    super.key,
    required this.categ,
  });

  final List<String> ctgImages = [
    cars,
    motors,
    electronic,
    home,
    sports,
    clothing,
    ecomiric,
    more,
  ];

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
            Category category = categ[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => CategoryChildrenView(
                      parentId: category.id,
                      parentName: category.name,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      ctgImages[
                          index % ctgImages.length], 
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.name,
                    style: TextStyles.reguler14.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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
