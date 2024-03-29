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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: IndexedSemantics(
                index: 0,
                child: ItemCardImage(
                  image: dog.image,
                  label: dog.imageLabel,
                ),
              ),
            ),
            const ExcludeSemantics(child: SizedBox(height: 8)),
            Flexible(
              child: IndexedSemantics(
                index: 1,
                child: ItemCardTitle(title: dog.title),
              ),
            ),
            const ExcludeSemantics(child: SizedBox(height: 16)),
            Flexible(
              child: IndexedSemantics(
                index: 2,
                child: ItemCardDescription(description: dog.description),
              ),
            ),
            const ExcludeSemantics(child: SizedBox(height: 16)),
            Flexible(
              child: IndexedSemantics(
                index: 3,
                child: ItemFavoriteButton(dog: dog),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
