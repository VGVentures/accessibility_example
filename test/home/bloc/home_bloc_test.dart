// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_accessibility/app/app.dart';
import 'package:very_good_accessibility/generated/assets.gen.dart';
import 'package:very_good_accessibility/home/home.dart';

void main() {
  late HomeBloc homeBloc;

  setUp(() {
    homeBloc = HomeBloc();
  });

  group('HomeBloc', () {
    group('DogsRequested', () {
      blocTest<HomeBloc, HomeState>(
        'emits a dogs list and status success '
        'when DogsRequested is added',
        build: () => homeBloc,
        act: (bloc) => bloc.add(DogsRequested()),
        expect: () => [
          HomeState(dogs: dogs, status: HomeStatus.success),
        ],
      );
    });

    group('UpdateFavoriteRequested', () {
      final dog = Dog(
        image: Assets.images.schnauzer.path,
        imageLabel: 'Two Miniature Schnauzer smiling and playing',
        title: 'Miniature Schnauzer',
        description: 'Stocky, robust little dogs standing 12 to 14 inches, '
            'Miniature Schnauzers were bred down from their larger '
            'cousins, Standard Schnauzers. The bushy beard and eyebrows '
            'give Minis a charming, human-like expression. The hard, wiry '
            'coat comes in three color patterns: salt and pepper, '
            'black and silver, and solid black.',
      );
      blocTest<HomeBloc, HomeState>(
        'added dog is to favorite dogs list and emit the updated list',
        build: () => homeBloc,
        act: (bloc) => bloc.add(UpdateFavoriteRequested(dog: dog)),
        expect: () => [
          HomeState(favoriteDogs: [dog]),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'remove dog from favorite dogs list and emit the updated list',
        build: () => homeBloc,
        act: (bloc) => bloc.add(UpdateFavoriteRequested(dog: dog)),
        seed: () => HomeState(favoriteDogs: [dog]),
        expect: () => [HomeState()],
      );
    });

    group('ChangeSelectedIndexRequested', () {
      blocTest<HomeBloc, HomeState>(
        'emits selectedIndex',
        build: () => homeBloc,
        act: (bloc) => bloc.add(ChangeSelectedIndexRequested(index: 1)),
        seed: () => HomeState(selectedIndex: 2),
        expect: () => [HomeState(selectedIndex: 1)],
      );
    });
  });
}
