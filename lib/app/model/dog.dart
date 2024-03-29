import 'package:equatable/equatable.dart';

class Dog extends Equatable {
  const Dog({
    required this.description,
    required this.image,
    required this.title,
    required this.imageLabel,
  });

  final String description;
  final String image;
  final String title;
  final String imageLabel;

  /// An empty dog.
  static const Dog empty = Dog(
    description: '',
    image: '',
    title: '',
    imageLabel: '',
  );

  @override
  List<Object?> get props => [
        description,
        image,
        title,
        imageLabel,
      ];
}
