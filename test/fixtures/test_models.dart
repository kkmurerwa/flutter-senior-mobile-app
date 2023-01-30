import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';

final tOrderItem = OrderItem(
    id: 1,
    pickUpPoint: "pickUpPoint",
    dropOffPoint: "dropOffPoint",
    weight: 1.0,
    instructions: "instructions",
    createdAt: DateTime.now(),
    createdBy: "createdBy"
);

final tOrderItemModel = OrderItemModel(
    id: 1,
    pickUpPoint: "pickUpPoint",
    dropOffPoint: "dropOffPoint",
    weight: 1.0,
    instructions: "instructions",
    createdAt: DateTime(2023,1, 30),
    createdBy: "createdBy"
);