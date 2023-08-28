// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_accessibility/app/app.dart';
import 'package:very_good_accessibility/home/home.dart';

void main() {
  test('supports value comparisons', () {
    expect(HomeState(), HomeState());
  });

  test('returns different object', () {
    expect(
      HomeState(),
      isNot(
        HomeState(status: HomeStatus.success),
      ),
    );
  });

  test('returns object with updated status when status is passed', () {
    expect(
      HomeState().copyWith(status: HomeStatus.initial),
      HomeState(),
    );
  });

  test('returns object with updated user when dogs is passed', () {
    final dogs = [
      Dog(
        title: 'title',
        description: 'description',
        image: 'image',
        imageLabel: 'imageLabel',
      ),
    ];

    expect(
      HomeState().copyWith(dogs: dogs),
      HomeState(dogs: dogs),
    );
  });

  test('returns object with updated user when favoriteDogs is passed', () {
    final favoriteDogs = [
      Dog(
        title: 'title',
        description: 'description',
        image: 'image',
        imageLabel: 'imageLabel',
      ),
    ];

    expect(
      HomeState().copyWith(favoriteDogs: favoriteDogs),
      HomeState(favoriteDogs: favoriteDogs),
    );
  });

  test('returns object with updated user when selectedIndex is passed', () {
    expect(
      HomeState().copyWith(selectedIndex: 1),
      HomeState(selectedIndex: 1),
    );
  });
}
