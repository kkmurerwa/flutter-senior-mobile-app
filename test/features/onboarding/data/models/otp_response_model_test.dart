import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/data/models/otp_response_model.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/otp_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/test_models.dart';

void main() {
  test('OtpResponseModel item should be a subclass of OTPResponse entity', () async {
    // assert
    expect(tOtpResponseModel, isA<OtpResponse>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is parsed', () async {
      // act
      final result = OtpResponseModel.fromJson(json.decode(fixture('otp_response.json')));

      // assert
      expect(result.toString(), tOtpResponseModel.toString());
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
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