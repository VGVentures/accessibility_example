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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemCardImage(image: dog.image, label: dog.imageLabel),
          const ExcludeSemantics(child: SizedBox(height: 8)),
          ItemCardTitle(
            title: dog.title,
            label: dog.titleLabel,
          ),
          const ExcludeSemantics(child: SizedBox(height: 16)),
          ItemCardDescription(
            description: dog.description,
            label: dog.descriptionLabel,
          ),
          const ExcludeSemantics(child: SizedBox(height: 16)),
          ItemFavorite(dog: dog)
        ],
      ),
    );
  }
}
