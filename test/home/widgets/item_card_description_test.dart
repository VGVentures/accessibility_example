// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_accessibility/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('ItemCardDescription', (tester) async {
    await tester.pumpApp(
      ItemCardDescription(description: 'description'),
    );
  });
}
