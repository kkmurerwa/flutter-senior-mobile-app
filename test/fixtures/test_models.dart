import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';

final tOrder = OrderItem(
    id: 1,
    pickUpPoint: "pickUpPoint",
    dropOffPoint: "dropOffPoint",
    weight: 1.0,
    instructions: "instructions",
    createdAt: DateTime.now(),
    createdBy: "createdBy"
);