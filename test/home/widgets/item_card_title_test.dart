// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_accessibility/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('ItemCardTitle', (tester) async {
    await tester.pumpApp(
      ItemCardTitle(title: 'title'),
    );
  });
}
