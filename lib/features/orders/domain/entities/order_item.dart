import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter_senior_mobile_app/features/orders/data/daos/orders_dao.dart';

@Entity(tableName: ORDERS_TABLE)
class OrderItem extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String pickUpPoint;
  final String dropOffPoint;
  final double weight;
  final String instructions;
  final int createdAt;
  final String createdBy;

  const OrderItem({
    required this.id,
    required this.pickUpPoint,
    required this.dropOffPoint,
    required this.weight,
    required this.instructions,
    required this.createdAt,
    required this.createdBy
  });

  @override
  List<Object?> get props => [
    id,
    pickUpPoint,
    dropOffPoint,
    weight,
    instructions,
    createdAt,
    createdBy
  ];

}
