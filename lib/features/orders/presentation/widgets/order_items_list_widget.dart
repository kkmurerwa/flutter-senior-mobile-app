import 'package:flutter/material.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';

class OrderItemsList extends StatelessWidget {
  const OrderItemsList({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final List<OrderItem> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Text("No orders yet"),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final currentOrder = orders[index];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildText(
              title: "Pick up point",
              text: currentOrder.pickUpPoint,
            ),
            const SizedBox(height: 10.0),
            buildText(
              title: "Drop off point",
              text: currentOrder.dropOffPoint
            ),
            const SizedBox(height: 10.0),
            buildText(
              title: "Pick up point",
              text: currentOrder.pickUpPoint
            ),
            const SizedBox(height: 10.0),
            buildText(
              title: "Estimated weight",
              text: "${currentOrder.weight} kg"
            ),
            const SizedBox(height: 10.0),
            buildText(
              title: "Delivery instructions",
              text: currentOrder.instructions
            ),
            const SizedBox(height: 10.0),
            const Divider(),
          ],
        );
      },
    );
  }

  Row buildText({required String title, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        Text(text),
      ],
    );
  }
}