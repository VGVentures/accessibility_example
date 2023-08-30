import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_accessibility/favorites/view/favorites_page.dart';
import 'package:very_good_accessibility/home/home.dart';
import 'package:very_good_accessibility/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedIndex =
        context.select((HomeBloc bloc) => bloc.state.selectedIndex);

    final pages = [
      const HomeView(),
      const FavoritesPage(),
    ];

    final mediaQuery = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQuery.copyWith(
        accessibleNavigation: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          excludeHeaderSemantics: true,
          title: Text(
            l10n.homeAppBarTitle,
            semanticsLabel: '${l10n.homeAppBarTitle} AppBar',
          ),
        ),
        body: pages.elementAt(selectedIndex),
        bottomNavigationBar: Semantics(
          child: BottomNavigationBar(
            onTap: (value) => context.read<HomeBloc>().add(
                  ChangeSelectedIndexRequested(index: value),
                ),
            currentIndex: selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                tooltip: 'Home page',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
                tooltip: 'Favorites page',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;

    return state.status == HomeStatus.success
        ? const DogsList()
        : const Center(child: CircularProgressIndicator());
  }
}

class DogsList extends StatelessWidget {
  const DogsList({super.key});

  @override
  Widget build(BuildContext context) {
    final dogs = context.select((HomeBloc bloc) => bloc.state.dogs);

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: dogs.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: IndexedSemantics(
          index: index,
          child: ItemCard(
            dog: dogs[index],
          ),
        ),
      ),
    );
  }
}
