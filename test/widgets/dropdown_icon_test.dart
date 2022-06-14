import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_dropdown/widgets/dropdown_icon.dart';

void main() {
  testWidgets('Dropdown Icon animates', (WidgetTester tester) async {
    AnimationController animationController = AnimationController(
      vsync: tester,
      duration: const Duration(milliseconds: 100),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: DropdownIcon(
              controller: animationController,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(Icon).evaluate().first.size, const Size(24, 24));

    animationController.forward();

    await tester.pumpAndSettle();

    RotationTransition actualRotatedBox =
        tester.widget(find.byKey(DropdownIcon.translationKey).first);
    double actualTurns = actualRotatedBox.turns.value;
    expect(actualTurns, -0.5);
  });
}
