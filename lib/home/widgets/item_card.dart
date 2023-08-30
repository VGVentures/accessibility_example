import 'package:flutter/material.dart';
import 'package:very_good_accessibility/app/app.dart';
import 'package:very_good_accessibility/home/home.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    required this.dog,
    super.key,
  });

  final Dog dog;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(8),
      child: MergeSemantics(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            ItemCardImage(
              image: dog.image,
              label: dog.imageLabel,
            ),
            const SizedBox(height: 8),
            ItemCardTitle(title: dog.title),
            const SizedBox(height: 16),
            ItemCardDescription(description: dog.description),
            const SizedBox(height: 16),
            ItemFavoriteButton(dog: dog),
          ],
        ),
      ),
    );
  }
}
