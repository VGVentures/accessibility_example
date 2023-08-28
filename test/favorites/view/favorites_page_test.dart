// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_accessibility/favorites/favorites.dart';
import 'package:very_good_accessibility/home/home.dart';

import '../../helpers/helpers.dart';

class _MockHomeBloc extends MockBloc<HomeEvent, HomeState>
    implements HomeBloc {}

void main() {
  late HomeBloc homeBloc;

  setUp(() {
    homeBloc = _MockHomeBloc();
    when(() => homeBloc.state).thenReturn(const HomeState());
  });

  testWidgets('renders FavoritePage', (tester) async {
    await tester.pumpApp(
      FavoritesPage(),
      homeBloc: homeBloc,
    );
    expect(find.byType(FavoritesPage), findsOneWidget);
  });

  testWidgets('renders FavoriteView', (tester) async {
    await tester.pumpApp(
      FavoritesPage(),
      homeBloc: homeBloc,
    );
    expect(find.byType(FavoritesView), findsOneWidget);
  });
}
