import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/navigation/navigation.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/widgets/message_display.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/widgets/order_items_list_widget.dart';
import 'package:flutter_senior_mobile_app/injection_container.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({Key? key}) : super(key: key);

  BuildContext? blocContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: buildBody(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, right: 30.0),
        child: FloatingActionButton(
          onPressed: () {
            // Navigate to create order page
            Navigator.pushNamed(context, Routes.createOrder).whenComplete(() {
              if (blocContext != null) {
                dispatchEvent(blocContext!);
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      )
    );
  }

  BlocProvider<OrdersBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OrdersBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              blocContext = context;

              if (state is OrdersEmptyState) {
                dispatchEvent(context);
              }

              if (state is OrdersLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is OrdersLoadedState) {
                final orders = state.orders;

                return OrderItemsList(orders: orders);
              } else if (state is OrdersErrorState) {
                return MessageDisplay(message: state.message);
              } else {
                return const MessageDisplay(message: 'An unexpected error occurred');
              }
            },
          ),
        ),
      ),
    );
  }

  void dispatchEvent(BuildContext context) {
    BlocProvider.of<OrdersBloc>(context).add(GetOrdersEvent());
  }
}
