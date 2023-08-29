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

    final label = isFavorite ? 'Remove button' : 'Add button';
    const iconLabel = 'Heart button icon';

    return Align(
      alignment: Alignment.centerRight,
      child: Semantics(
        liveRegion: true,
        key: Key('item_favorite_button_${dog.title}'),
        button: true,
        label: label,
        selected: isFavorite,
        onTap: () => context.read<HomeBloc>().add(
              UpdateFavoriteRequested(dog: dog),
            ),
        onTapHint: onTapHint,
        child: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            semanticLabel: iconLabel,
          ),
          onPressed: () => context.read<HomeBloc>().add(
                UpdateFavoriteRequested(dog: dog),
              ),
        ),
      ),
    );
  }
}
