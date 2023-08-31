// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
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
      final item = find.byType(IconButton).first;
      await tester.tap(item);
      await tester.pumpAndSettle();
      verify(() => homeBloc.add(UpdateFavoriteRequested(dog: dog))).called(1);
    });
  });

  group('semantics', () {
    final dog = Dog(
      title: 'title',
      description: 'description',
      image: Assets.images.schnauzer.path,
      imageLabel: 'imageLabel',
    );

    testWidgets('matchSemantics when remove from favorites', (tester) async {
      final handle = tester.ensureSemantics();
      when(() => homeBloc.state).thenReturn(
        HomeState(favoriteDogs: [dog]),
      );

      await tester.pumpApp(
        ItemFavoriteButton(dog: dog),
        homeBloc: homeBloc,
      );

      final item = find
          .ancestor(
            of: find.byType(IconButton).first,
            matching: find.byType(Semantics),
          )
          .first;

      expect(
        tester.getSemantics(item),
        matchesSemantics(
          isSelected: true,
          hasTapAction: true,
          isLiveRegion: true,
          isButton: true,
          onTapHint: 'Remove ${dog.title} from favorites',
        ),
      );

      handle.dispose();
    });

    testWidgets('matchSemantics when add to favorites', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpApp(
        ItemFavoriteButton(dog: dog),
        homeBloc: homeBloc,
      );

      final item = find
          .ancestor(
            of: find.byType(IconButton).first,
            matching: find.byType(Semantics),
          )
          .first;

      expect(
        tester.getSemantics(item),
        matchesSemantics(
          hasTapAction: true,
          isButton: true,
          isLiveRegion: true,
          onTapHint: 'Add ${dog.title} to favorites',
        ),
      );

      handle.dispose();
    });

    testWidgets('onTap semantics', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpApp(
        ItemFavoriteButton(dog: dog),
        homeBloc: homeBloc,
      );

      final item = find
          .ancestor(
            of: find.byType(IconButton).first,
            matching: find.byType(Semantics),
          )
          .first;

      final semantics = tester.getSemantics(item);

      tester.binding.pipelineOwner.semanticsOwner!.performAction(
        semantics.id,
        SemanticsAction.tap,
      );

      verify(() => homeBloc.add(UpdateFavoriteRequested(dog: dog))).called(1);

      handle.dispose();
    });

    testWidgets('meets guidelines', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpApp(
        ItemFavoriteButton(dog: dog),
        homeBloc: homeBloc,
      );

      // Checks that tappable nodes have a minimum size of 48 by 48 pixels
      // for Android.
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      // Checks that tappable nodes have a minimum size of 44 by 44 pixels
      // for iOS.
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      // Checks that touch targets with a tap or long press action are labeled.
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      // Checks whether semantic nodes meet the minimum text contrast levels.
      // The recommended text contrast is 3:1 for larger text
      // (18 point and above regular).
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
  });
}
