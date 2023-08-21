import 'package:equatable/equatable.dart';

class Dog extends Equatable {
  const Dog({
    required this.description,
    required this.image,
    required this.title,
    required this.titleLabel,
    required this.descriptionLabel,
    required this.imageLabel,
  });

  final String description;
  final String image;
  final String title;
  final String titleLabel;
  final String descriptionLabel;
  final String imageLabel;

  static Dog empty = const Dog(
    description: '',
    image: '',
    title: '',
    titleLabel: '',
    descriptionLabel: '',
    imageLabel: '',
  );

  @override
  List<Object?> get props => [
        description,
        image,
        title,
        titleLabel,
        descriptionLabel,
        imageLabel,
      ];
}
