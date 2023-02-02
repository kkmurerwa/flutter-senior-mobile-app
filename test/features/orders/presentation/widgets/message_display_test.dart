import 'package:flutter/material.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/widgets/message_display.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MessageDisplay should display passed the message', (tester) async {
    // arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: MessageDisplay(message: 'Hello'),
      ),
    );

    // assert
    final messageFinder = find.text('Hello');
    expect(messageFinder, findsOneWidget);
  });
}