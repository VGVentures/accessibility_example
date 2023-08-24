import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_accessibility/app/app.dart';
import 'package:very_good_accessibility/home/home.dart';

class ItemFavoriteButton extends StatelessWidget {
  const ItemFavoriteButton({
    required this.dog,
    super.key,
  });
  final Dog dog;

  @override
  Widget build(BuildContext context) {
    final favoriteDogs =
        context.select((HomeBloc bloc) => bloc.state.favoriteDogs);
    final isFavorite = favoriteDogs.contains(dog);
    return Align(
      alignment: Alignment.centerRight,
      child: Semantics(
        button: true,
        selected: isFavorite,
        child: IconButton(
          icon: isFavorite
              ? const Icon(
                  Icons.favorite,
                  semanticLabel: 'Remove from favorites',
                )
              : const Icon(
                  Icons.favorite_border,
                  semanticLabel: 'Add to favorites',
                ),
          onPressed: () => context.read<HomeBloc>().add(
                UpdateFavoriteRequested(dog: dog),
              ),
        ),
      ),
    );
  }
}
