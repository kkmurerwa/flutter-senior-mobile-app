import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/daos/orders_dao.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [OrderItem])
abstract class AppDatabase extends FloorDatabase {
  OrdersDao get ordersDao;
}