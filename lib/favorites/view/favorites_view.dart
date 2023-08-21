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
        ? ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            itemBuilder: (context, index) {
              final dog = favoriteDogs[index];
              return ListTile(
                leading: ItemCardImage(image: dog.image, label: dog.imageLabel),
                title: Text(dog.title),
                subtitle: Text(dog.description),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    semanticLabel: 'Remove ${dog.title} from favorites',
                  ),
                  onPressed: () => context.read<HomeBloc>().add(
                        UpdateFavoriteRequested(dog: dog),
                      ),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                const ExcludeSemantics(child: SizedBox(height: 16)),
            itemCount: favoriteDogs.length,
          )
        : Center(
            child: MergeSemantics(
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
          );
  }
}
