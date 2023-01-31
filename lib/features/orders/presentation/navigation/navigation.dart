import 'package:flutter/material.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/pages/create_order_page.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/pages/orders_page.dart';

// Declare routes
class Routes {
  static const String orders = '/';
  static const String createOrder = '/create_order';

  static const initialRoute = orders;

  static final Map<String, WidgetBuilder> routes = {
    orders: (context) => OrdersPage(),
    createOrder: (context) => CreateOrderPage(),
  };
}