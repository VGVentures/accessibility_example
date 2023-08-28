// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_accessibility/app/app.dart';
import 'package:very_good_accessibility/generated/assets.gen.dart';
import 'package:very_good_accessibility/home/home.dart';

import '../../helpers/helpers.dart';

class _MockHomeBloc extends MockBloc<HomeEvent, HomeState>
    implements HomeBloc {}

void main() {
  late HomeBloc homeBloc;

  setUp(() {
    homeBloc = _MockHomeBloc();
    when(() => homeBloc.state).thenReturn(HomeState());
  });

  testWidgets('ItemFavorite', (tester) async {
    final dog = Dog(
      title: 'title',
      description: 'description',
      image: Assets.images.schnauzer.path,
      imageLabel: 'imageLabel',
    );

    await tester.pumpApp(
      ItemFavoriteButton(dog: dog),
      homeBloc: homeBloc,
    );

    expect(find.byType(ItemFavoriteButton), findsOneWidget);
  });

  group('add', () {
    testWidgets('ItemFavorite', (tester) async {
      final dog = Dog(
        title: 'title',
        description: 'description',
        image: Assets.images.schnauzer.path,
        imageLabel: 'imageLabel',
      );

      await tester.pumpApp(
        ItemFavoriteButton(dog: dog),
        homeBloc: homeBloc,
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      verify(() => homeBloc.add(UpdateFavoriteRequested(dog: dog))).called(1);
    });
  });
}
