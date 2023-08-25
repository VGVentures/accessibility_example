// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_accessibility/generated/assets.gen.dart';
import 'package:very_good_accessibility/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  testWidgets('ItemCardImage', (tester) async {
    await tester.pumpApp(
      ItemCardImage(
        image: Assets.images.schnauzer.path,
        label: 'label',
      ),
    );
  });
}
