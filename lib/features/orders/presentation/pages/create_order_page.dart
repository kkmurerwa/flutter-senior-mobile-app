import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';
import 'package:flutter_senior_mobile_app/features/orders/presentation/bloc/orders_bloc.dart';
import 'package:flutter_senior_mobile_app/injection_container.dart';

import '../widgets/message_display.dart';

class CreateOrderPage extends StatelessWidget {
  CreateOrderPage({Key? key}) : super(key: key);

  late TextEditingController _pickUpPointController;
  late TextEditingController _dropOffPointController;
  late TextEditingController _estimatedWeightController;
  late TextEditingController _deliveryInstructionsController;

  late GlobalKey<FormState> _formKey;

  init() {
    _pickUpPointController = TextEditingController();
    _dropOffPointController = TextEditingController();
    _estimatedWeightController = TextEditingController();
    _deliveryInstructionsController = TextEditingController();

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    init();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Order"),
      ),
      body: buildBody(context)
    );
  }

  BlocProvider<OrdersBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OrdersBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersEmptyState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Fill Below To Order",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        buildTitleText(text: "Pick up point"),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _pickUpPointController,
                            hintText: "The Address, Waiyaki Way, Westlands",
                            validator: notEmptyValidator,
                            keyboardType: TextInputType.streetAddress
                        ),
                        const SizedBox(height: 20),
                        buildTitleText(text: "Drop off point"),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _dropOffPointController,
                            hintText: "Green Shades, Ngo'ng Road, Lavington",
                            validator: notEmptyValidator,
                            keyboardType: TextInputType.streetAddress
                        ),
                        const SizedBox(height: 20),
                        buildTitleText(text: "Estimated weight"),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _estimatedWeightController,
                            hintText: "15.73",
                            validator: notEmptyValidator,
                            keyboardType: TextInputType.number
                        ),
                        const SizedBox(height: 20),
                        buildTitleText(text: "Delivery instructions"),
                        const SizedBox(height: 10),
                        buildTextField(
                            controller: _deliveryInstructionsController,
                            hintText: "Call me on 0701234567 when you arrive",
                            validator: notEmptyValidator,
                            keyboardType: TextInputType.text
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            validateAndSubmit(context);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF451926),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              )
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                            child: Text(
                              "Confirm & Order a trip",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is OrdersLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is OrderCreatedState) {
              Navigator.pop(context);

              return const MessageDisplay(message: "Order created successfully");
            } else if (state is OrdersErrorState) {
              return MessageDisplay(message: state.message);
            } else {
              return const MessageDisplay(message: 'An unexpected error occurred');
            }
          },
        ),
      ),
    );
  }

  TextFormField buildTextField({
    required TextEditingController controller,
    required String hintText,
    required validator,
    required TextInputType keyboardType,
  }) {
    return TextFormField(
      validator: (value) {
        if (keyboardType == TextInputType.number) {
          if (value == null || value.isEmpty) {
            return "Please enter a valid value";
          }
          if (double.tryParse(value) == null) {
            return "Please enter a valid number";
          }
          return null;
        } else {
          return validator(value);
        }
      },
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: "e.g. $hintText"
      ),
      keyboardType: keyboardType
    );
  }

  Text buildTitleText({
    required String text
  }) {
      return Text(
        text,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal
        ),
      );
  }

  String? notEmptyValidator (value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid value";
    }
    return null;
  }

  void validateAndSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String pickUpPoint = _pickUpPointController.text;
      String dropOffPoint = _dropOffPointController.text;
      String estimatedWeight = _estimatedWeightController.text;
      String deliveryInstructions = _deliveryInstructionsController.text;

      double weightDouble = double.parse(estimatedWeight);

      final orderItem = OrderItem(
        // id: 1,
        pickUpPoint: pickUpPoint,
        dropOffPoint: dropOffPoint,
        weight: weightDouble,
        instructions: deliveryInstructions,
        createdAt: DateTime.now().microsecondsSinceEpoch,
        createdBy: '1'
      );

      BlocProvider.of<OrdersBloc>(context).add(CreateOrderEvent(order: orderItem));
    }
  }
}
