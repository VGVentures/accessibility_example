// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_accessibility/favorites/view/favorites_page.dart';
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

  group('HomePage', () {
    group('BottomNavigationBar', () {
      testWidgets('renders HomeView', (tester) async {
        await tester.pumpApp(
          HomePage(),
          homeBloc: homeBloc,
        );

        final bottomNavWidget = tester.widget<BottomNavigationBar>(
          find.byType(BottomNavigationBar),
        );

        expect(bottomNavWidget.currentIndex, 0);
        expect(find.byType(HomeView), findsOneWidget);
        expect(find.byType(FavoritesPage), findsNothing);
        expect(find.byIcon(Icons.home), findsOne);
      });

      testWidgets('renders FavoritesPage', (tester) async {
        when(() => homeBloc.state).thenReturn(HomeState(selectedIndex: 1));

        await tester.pumpApp(
          HomePage(),
          homeBloc: homeBloc,
        );

        final bottomNavWidget = tester.widget<BottomNavigationBar>(
          find.byType(BottomNavigationBar),
        );
        expect(bottomNavWidget.currentIndex, 1);
        expect(find.byType(FavoritesPage), findsOneWidget);
        expect(find.byType(HomeView), findsNothing);
      });

      testWidgets('onTap', (tester) async {
        await tester.pumpApp(
          HomePage(),
          homeBloc: homeBloc,
        );

        final bottomNavWidget = tester.widget<BottomNavigationBar>(
          find.byType(BottomNavigationBar),
        );
        bottomNavWidget.onTap!(1);

        verify(() => homeBloc.add(ChangeSelectedIndexRequested(index: 1)))
            .called(1);
      });
    });

    group('HomeView', () {
      testWidgets(
          'renders CircularProgressIndicator when '
          'HomeStatus.loading', (tester) async {
        when(() => homeBloc.state).thenReturn(
          HomeState(status: HomeStatus.loading),
        );
        await tester.pumpApp(
          HomePage(),
          homeBloc: homeBloc,
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('renders DogsList when HomeStatus.success', (tester) async {
        when(() => homeBloc.state).thenReturn(
          HomeState(status: HomeStatus.success, dogs: dogs),
        );
        await tester.pumpApp(
          HomePage(),
          homeBloc: homeBloc,
        );

        expect(find.byType(DogsList), findsOneWidget);
      });
    });
  });
}
