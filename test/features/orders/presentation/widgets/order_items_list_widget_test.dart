import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/widgets/order_items_list_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/test_models.dart';

void main() {

  String titleFormatter(String title) {
    return "$title: ";
  }

  testWidgets('should display no orders test if orders list is empty', (tester) async {
    // act
    await tester.pumpWidget(
      const MaterialApp(
        home: OrderItemsList(orders: []),
      ),
    );

    // assert
    final noOrdersTextFinder = find.text('No orders yet');
    expect(noOrdersTextFinder, findsOneWidget);
  });

  testWidgets('should display list of widgets if at least one order item passed', (tester) async {
    // act
    await tester.pumpWidget(
      MaterialApp(
        home: OrderItemsList(orders: [tOrderItem]),
      ),
    );

    // assert
    expect(find.byKey(const ValueKey("currentOrderCard")), findsOneWidget);
    expect(find.byType(Row), findsNWidgets(4));
    expect(find.text(tOrderItem.pickUpPoint), findsOneWidget);
    expect(find.text(tOrderItem.dropOffPoint), findsOneWidget);
    expect(find.text("${tOrderItem.weight} kg"), findsOneWidget);
    expect(find.text(tOrderItem.instructions), findsOneWidget);
  });

  testWidgets('buildText method should return Row with two Text children', (tester) async {
    // arrange
    final buildTextWidget = const OrderItemsList(orders: [],)
        .buildText(title: 'title', text: 'text');

    // act
    await tester.pumpWidget(
      MaterialApp(
        home: buildTextWidget,
      ),
    );

    // assert
    final textWidgetFinder = find.byType(Text);
    expect(textWidgetFinder, findsNWidgets(2));

    final titleTextFinder = find.text(titleFormatter('title'));
    expect(titleTextFinder, findsOneWidget);

    final textTextFinder = find.text('text');
    expect(textTextFinder, findsOneWidget);
  });
}