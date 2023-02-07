import 'dart:convert';

import 'package:flutter_senior_mobile_app/core/errors/exceptions.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/data/datasources/onboarding_remote_data_source.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/data/models/otp_response_model.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/otp_response.dart';
import 'package:flutter_senior_mobile_app/features/onboarding/domain/entities/verification_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late OnboardingRemoteDataSourceImpl dataSource;

  setUp(() async {
    mockHttpClient = MockHttpClient();
    dataSource = OnboardingRemoteDataSourceImpl(client: mockHttpClient);

    registerFallbackValue(Uri());
  });

  group('requestOtp', () {
    test('should create Http request for OTP when called', () async {
      // arrange
      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{"status": "success"}', 200));

      // act
      dataSource.requestOtp('');

      // assert
      verify(() => mockHttpClient.post(any(), body: any(named: 'body'))).called(1);
    });

    test('should return OtpResponseModel when the response code is 200', () async {
      // arrange
      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response(fixture('otp_response.json'), 200));

      // act
      final result = await dataSource.requestOtp('');

      // assert
      result.fold((l) => 'test failed', (r) => {
        expect(r, isA<OtpResponseModel>()),
        expect(r.status, 'success'),
      });
    });

    test('should return ServerException when the response code is 400', () async {
      // arrange
      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{"status": "error"}', 400));

      // act
      final result = await dataSource.requestOtp('');

      // assert
      result.fold((l) => {
        expect(l, isA<ServerException>()),
        expect(l, 'Server Error'),
      }, (r) => 'test failed');
    });
  });

  group('verifyOtp', () {
    test('should create Http request for verification when called', () async {
      // arrange
      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{"status": "success"}', 200));

      // act
      dataSource.verifyOtp('', '');

      // assert
      verify(() => mockHttpClient.post(any(), body: any(named: 'body'))).called(1);
    });

    test('should return VerificationResponseModel when the response code is 200', () async {
      // arrange
      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response(fixture('otp_response.json'), 200));

      // act
      final result = await dataSource.verifyOtp('', '');

      // assert
      result.fold((l) => 'test failed', (r) => {
        expect(r, isA<VerificationResponse>())
      });
    });

    test('should return ServerException when the response code is 400 for verification', () async {
      // arrange
      when(() => mockHttpClient.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{"status": "error"}', 400));

      // act
      final result = await dataSource.verifyOtp('', '');

      // assert
      result.fold((l) => {
        expect(l, isA<ServerException>())
      }, (r) => 'test failed');
    });
  });
}