import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_accessibility/app/app.dart';
import 'package:very_good_accessibility/home/home.dart';

void main() {
  group('HomeEvent', () {
    group('UpdateFavoriteRequested', () {
      const dog = Dog(
        title: 'title',
        description: 'description',
        image: 'image',
        imageLabel: 'imageLabel',
      );

      const dog2 = Dog(
        title: 'title2',
        description: 'description2',
        image: 'image2',
        imageLabel: 'imageLabel2',
      );
      test('supports value comparisons', () {
        expect(
          UpdateFavoriteRequested(dog: dog),
          UpdateFavoriteRequested(dog: dog),
        );

        expect(
          UpdateFavoriteRequested(dog: dog),
          isNot(
            UpdateFavoriteRequested(dog: dog2),
          ),
        );
      });
    });

    group('DogsRequested', () {
      test('supports value comparisons', () {
        expect(
          DogsRequested(),
          DogsRequested(),
        );
      });
    });

    group('ChangeSelectedIndexRequested', () {
      test('supports value comparisons', () {
        expect(
          ChangeSelectedIndexRequested(index: 1),
          ChangeSelectedIndexRequested(index: 1),
        );

        expect(
          ChangeSelectedIndexRequested(index: 1),
          isNot(
            ChangeSelectedIndexRequested(index: 2),
          ),
        );
      });
    });
  });
}
