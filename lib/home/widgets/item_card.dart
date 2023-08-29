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
      semanticContainer: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(8),
      child: MergeSemantics(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            IndexedSemantics(
              index: 0,
              child: ItemCardImage(
                image: dog.image,
                label: dog.imageLabel,
              ),
            ),
            SizedBox(height: 8),
            IndexedSemantics(index: 1, child: ItemCardTitle(title: dog.title)),
            SizedBox(height: 16),
            IndexedSemantics(
                index: 2,
                child: ItemCardDescription(description: dog.description)),
            SizedBox(height: 16),
            IndexedSemantics(index: 3, child: ItemFavoriteButton(dog: dog)),
          ],
        ),
      ),
    );
  }
}
