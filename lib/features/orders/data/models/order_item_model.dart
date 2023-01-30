import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {

  const OrderItemModel({
    required int id,
    required String pickUpPoint,
    required String dropOffPoint,
    required double weight,
    required String instructions,
    required DateTime createdAt,
    required String createdBy
  }): super(
    id: id,
    pickUpPoint: pickUpPoint,
    dropOffPoint: dropOffPoint,
    weight: weight,
    instructions: instructions,
    createdAt: createdAt,
    createdBy: createdBy
  );

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      pickUpPoint: json['pickUpPoint'],
      dropOffPoint: json['dropOffPoint'],
      weight: (json['weight'] as num).toDouble(),
      instructions: json['instructions'],
      createdAt: DateTime.parse(json['createdAt']),
      createdBy: json['createdBy']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pickUpPoint': pickUpPoint,
      'dropOffPoint': dropOffPoint,
      'weight': weight,
      'instructions': instructions,
      'createdAt': createdAt.toIso8601String(),
      'createdBy': createdBy
    };
  }

}