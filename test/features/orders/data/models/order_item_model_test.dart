import 'dart:convert';

import 'package:flutter_senior_mobile_app/features/orders/data/models/order_item_model.dart';
import 'package:flutter_senior_mobile_app/features/orders/domain/entities/order_item.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/test_models.dart';

void main() {
  test('should be subclass of OrderItem entity', () async {
    expect(tOrderItemModel, isA<OrderItem>());
  });

  group('fromJson', () {
    test('should return a valid model when a JSON weight is double', () async {
      // act
      final result = OrderItemModel.fromJson(json.decode(fixture('order_double.json')));

      // assert
      expect(result, tOrderItemModel);
    });

    test('should return a valid model when the JSON weight is not double', () async {
      // act
      final result = OrderItemModel.fromJson(json.decode(fixture('order_integer.json')));

      // assert
      expect(result, tOrderItemModel);
    });

  });

  group('toJson', () {
    test('should return a valid json model when converted to json', () {
      // arrange
      final expectedJsonMap = {
        "id": 1,
        "pickUpPoint": "pickUpPoint",
        "dropOffPoint": "dropOffPoint",
        "weight": 1.0,
        "instructions": "instructions",
        "createdAt": "2023-01-30T00:00:00.000",
        "createdBy": "createdBy"
      };

      // act
      final result = tOrderItemModel.toJson();

      // assert
      expect(result, expectedJsonMap);
    });
  });

}