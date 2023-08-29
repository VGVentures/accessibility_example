// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
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
        final favoriteDogs = [dog];

        when(() => homeBloc.state)
            .thenReturn(HomeState(favoriteDogs: favoriteDogs));
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

    group('semantics', () {
      testWidgets('matchSemantics when remove from favorites', (tester) async {
        final handle = tester.ensureSemantics();
        when(() => homeBloc.state).thenReturn(
          HomeState(favoriteDogs: [dog]),
        );

        await tester.pumpApp(
          FavoritesView(),
          homeBloc: homeBloc,
        );
        final item = find.byKey(Key('favoriteDog_${dog.title}'));

        expect(
          tester.getSemantics(item),
          matchesSemantics(
            hasTapAction: true,
            isButton: true,
            isEnabled: true,
            isFocusable: true,
            hasEnabledState: true,
            isImage: true,
            onTapHint: 'Remove ${dog.title} from favorites',
          ),
        );
        handle.dispose();
      });

      testWidgets('onTap', (tester) async {
        final handle = tester.ensureSemantics();
        when(() => homeBloc.state).thenReturn(
          HomeState(favoriteDogs: [dog]),
        );

        await tester.pumpApp(
          FavoritesView(),
          homeBloc: homeBloc,
        );
        final item = find.byKey(Key('favoriteDog_${dog.title}'));
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
          FavoritesView(),
          homeBloc: homeBloc,
        );

        // Checks that tappable nodes have a minimum size of 48 by 48 pixels
        // for Android.
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        // Checks that tappable nodes have a minimum size of 44 by 44 pixels
        // for iOS.
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        // Checks that touch targets with a tap or long press '
        // action are labeled.
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        // Checks whether semantic nodes meet the minimum text contrast levels.
        // The recommended text contrast is 3:1 for larger text
        // (18 point and above regular).
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
    });
  });
}
