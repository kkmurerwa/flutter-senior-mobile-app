import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:flutter_senior_mobile_app/injection_container.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: buildBody(context),
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
              if (state is OrdersEmptyState) {
                dispatchEvent(context, GetOrdersEvent());
              }

              if (state is OrdersLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is OrdersLoadedState) {
                return Text("Orders found are shown below: ${state.orders}");
              } else if (state is OrdersErrorState) {
                return Text(state.message);
              } else {
                return const Text('An unexpected error occurred');
              }
            },
          ),
        ),
      ),
    );
  }

  void dispatchEvent(BuildContext context, OrdersEvent event) {
    BlocProvider.of<OrdersBloc>(context).add(event);
  }
}
