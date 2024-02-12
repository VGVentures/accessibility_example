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

    final onTapHint = isFavorite
        ? 'Remove ${dog.title} from favorites'
        : 'Add ${dog.title} to favorites';

    final label = isFavorite
        ? 'Button to remove ${dog.title} from favorites'
        : 'Button to add ${dog.title} to favorites';
    const iconLabel = 'Heart icon';

    return Align(
      alignment: Alignment.centerRight,
      child: Semantics(
        liveRegion: true,
        button: true,
        label: label,
        selected: isFavorite,
        onTap: () => _updateFavorites(context),
        onTapHint: onTapHint,
        child: IconButton(
          icon: AppIcon(
            icon: isFavorite ? Icons.favorite : Icons.favorite_border,
            fontSize: 14,
            label: iconLabel,
          ),
          onPressed: () => _updateFavorites(context),
        ),
      ),
    );
  }

  void _updateFavorites(BuildContext context) {
    context.read<HomeBloc>().add(
          UpdateFavoriteRequested(dog: dog),
        );
  }
}
