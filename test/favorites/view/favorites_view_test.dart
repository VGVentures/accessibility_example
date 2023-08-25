// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_accessibility/app/app.dart';
import 'package:very_good_accessibility/favorites/favorites.dart';
import 'package:very_good_accessibility/generated/assets.gen.dart';
import 'package:very_good_accessibility/home/home.dart';

import '../../helpers/helpers.dart';

class _MockHomeBloc extends MockBloc<HomeEvent, HomeState>
    implements HomeBloc {}

void main() {
  late HomeBloc homeBloc;
  final dog = Dog(
    title: 'title',
    description: 'description',
    image: Assets.images.schnauzer.path,
    imageLabel: 'imageLabel',
  );

  setUp(() {
    homeBloc = _MockHomeBloc();
    when(() => homeBloc.state).thenReturn(const HomeState());
  });
  group('FavoritesView', () {
    group('renders', () {
      testWidgets('FavoritesDogs when favoritesDogs is not empty',
          (tester) async {
        when(() => homeBloc.state).thenReturn(HomeState(favoriteDogs: [dog]));
        await tester.pumpApp(
          FavoritesView(),
          homeBloc: homeBloc,
        );

        expect(find.byType(FavoritesDogs), findsOneWidget);
      });

      testWidgets('NoFavoritesView when favoritesDogs is empty',
          (tester) async {
        await tester.pumpApp(
          FavoritesView(),
          homeBloc: homeBloc,
        );

        expect(find.byType(NoFavoritesView), findsOneWidget);
      });
    });

    group('adds', () {
      testWidgets('ChangeSelectedIndexRequested when click on go to home page',
          (tester) async {
        await tester.pumpApp(
          FavoritesView(),
          homeBloc: homeBloc,
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
        verify(() => homeBloc.add(ChangeSelectedIndexRequested(index: 0)))
            .called(1);
      });

      testWidgets('UpdateFavoriteRequested when click on delete icon',
          (tester) async {
        when(() => homeBloc.state).thenReturn(
          HomeState(
            favoriteDogs: [dog],
          ),
        );
        await tester.pumpApp(
          FavoritesView(),
          homeBloc: homeBloc,
        );

        await tester.tap(find.byType(IconButton));
        await tester.pumpAndSettle();
        verify(
          () => homeBloc.add(UpdateFavoriteRequested(dog: dog)),
        ).called(1);
      });
    });
  });
}
