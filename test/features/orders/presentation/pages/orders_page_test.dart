import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/pages/orders_page.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_senior_mobile_app/injection_container.dart' as di;
import 'package:integration_test/integration_test.dart';

import 'package:flutter_senior_mobile_app/main.dart' as app;
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await di.init();

    mockHttpClient = MockHttpClient();

    // app.main();
  });

  Widget buildTestableWidget(OrdersPage ordersPage) {
    return MaterialApp(
      home: ordersPage,
    );
  }

  testWidgets('OrdersPage has title', (tester) async {
    // given
    await tester.pumpWidget(buildTestableWidget(OrdersPage()));
    final titleFinder = find.text('Orders');

    // then
    expect(titleFinder, findsOneWidget);
  });
}