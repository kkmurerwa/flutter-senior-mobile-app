import 'dart:convert';

import 'package:flutter_senior_mobile_app/features/onboarding/data/models/verification_response_model.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/verification_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/test_models.dart';

void main() {

  test('should be a subclass of VerificationResponse entity', () async {
    // assert
    expect(tVerificationResponseModel, isA<VerificationResponse>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is true', () async {
      // act
      final result = VerificationResponseModel.fromJson(json.decode(fixture('verification_response.json')));

      // assert
      expect(result.toString(), tVerificationResponseModel.toString());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing data from passed OtpResponseModel instance', () async {
      // act
      final result = tOtpResponseModel.toJson();

      // assert
      final expectedMap = {
        "message": "test message",
        "status": "test status",
        "sent": true,
      };

      expect(result, expectedMap);
    });
  });
}