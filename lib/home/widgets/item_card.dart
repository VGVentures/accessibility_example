import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
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
            Semantics(
              sortKey: const OrdinalSortKey(2),
              child: ItemCardImage(
                image: dog.image,
                label: dog.imageLabel,
              ),
            ),
            const ExcludeSemantics(child: SizedBox(height: 8)),
            Semantics(
              header: true,
              sortKey: const OrdinalSortKey(0),
              child: ItemCardTitle(title: dog.title),
            ),
            const ExcludeSemantics(child: SizedBox(height: 16)),
            Semantics(
              sortKey: const OrdinalSortKey(1),
              child: ItemCardDescription(description: dog.description),
            ),
            const ExcludeSemantics(child: SizedBox(height: 16)),
            Semantics(
              sortKey: const OrdinalSortKey(3),
              child: ItemFavoriteButton(dog: dog),
            ),
          ],
        ),
      ),
    );
  }
}
