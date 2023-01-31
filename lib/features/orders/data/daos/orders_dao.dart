import 'package:floor/floor.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';

const String ORDERS_TABLE = "orders";

@dao
abstract class OrdersDao {
  @Query('SELECT * FROM $ORDERS_TABLE')
  Future<List<OrderItem>> getOrders();

  @Query('SELECT * FROM $ORDERS_TABLE WHERE id = :id')
  Future<OrderItem?> getOrderById(int id);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> createOrder(OrderItem order);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateOrder(OrderItem order);

  @Query('DELETE FROM $ORDERS_TABLE WHERE id = :id')
  Future<void> deleteOrder(int id);
}