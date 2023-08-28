import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_accessibility/home/home.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteDogs =
        context.select((HomeBloc bloc) => bloc.state.favoriteDogs);

    return favoriteDogs.isNotEmpty
        ? const FavoritesDogs()
        : const NoFavoritesView();
  }
}

class FavoritesDogs extends StatelessWidget {
  const FavoritesDogs({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteDogs =
        context.select((HomeBloc bloc) => bloc.state.favoriteDogs);

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      itemBuilder: (context, index) {
        final dog = favoriteDogs[index];
        return Semantics(
          key: Key('favoriteDog_${dog.title}'),
          liveRegion: true,
          onTap: () => context.read<HomeBloc>().add(
                UpdateFavoriteRequested(dog: dog),
              ),
          onTapHint: 'Remove ${dog.title} from favorites',
          child: MergeSemantics(
            child: ListTile(
              leading: ItemCardImage(image: dog.image, label: dog.imageLabel),
              title: Text(dog.title),
              subtitle: Text(dog.description),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => context.read<HomeBloc>().add(
                      UpdateFavoriteRequested(dog: dog),
                    ),
              ),
            ),
          ),
        );
      },
      itemCount: favoriteDogs.length,
    );
  }
}

class NoFavoritesView extends StatelessWidget {
  const NoFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MergeSemantics(
        child: Semantics(
          liveRegion: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No favorites, please go to Home Page to add more '
                'dogs to favorites',
                textAlign: TextAlign.center,
              ),
              const ExcludeSemantics(child: SizedBox(height: 16)),
              ElevatedButton(
                onPressed: () => context
                    .read<HomeBloc>()
                    .add(ChangeSelectedIndexRequested(index: 0)),
                child: const Text('Go to Home Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
