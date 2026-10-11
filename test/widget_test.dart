import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dinogame/main.dart';

void main() {
  testWidgets('shows the start screen and starts the game on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Start screen with an empty score and no game over overlay.
    expect(find.text('TAP TO PLAY'), findsOneWidget);
    expect(find.text('SCORE: 0'), findsOneWidget);
    expect(find.text('HIGHSCORE: 0'), findsOneWidget);
    expect(find.text('GAME OVER'), findsNothing);

    // Tapping anywhere starts the game and hides the start prompt.
    await tester.tap(find.byType(Scaffold));
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.text('TAP TO PLAY'), findsNothing);
    expect(find.text('GAME OVER'), findsNothing);

    // Removing the game disposes it, which must cancel the game timer
    // (otherwise the test fails with a pending timer).
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
