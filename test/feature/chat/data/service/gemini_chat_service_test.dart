import 'package:chat_bot/core/api/api_manager.dart';
import 'package:chat_bot/core/error/failures.dart'; // تأكد من استيراد الـ Failure
import 'package:chat_bot/feature/chat/data/model/chat_model.dart';
import 'package:chat_bot/feature/chat/data/service/gemini_chat_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiManager extends Mock implements ApiManager {}

void main() {
  late MockApiManager mockApiManager;
  late GeminiChatService service;

  setUp(() {
    mockApiManager = MockApiManager();
    service = GeminiChatService(apiManager: mockApiManager);
  });

  group("GeminiChatService Retry Logic Tests", () {
    final messages = [
      ChatModel(parts: [Parts(text: 'Hello')], role: 'user'),
    ];

    final responseData = {
      'candidates': [
        {
          'content': {
            'role': 'model',
            'parts': [
              {'text': 'ok'}
            ]
          }
        }
      ]
    };

    test('returns ChatModel when request succeeds on first attempt', () async {
      when(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).thenAnswer(
            (_) async => Response(
          data: responseData,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await service.sentMessage(messages);

      expect(result.role, 'model');
      expect(result.parts!.first.text, 'ok');
      verify(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).called(1);
    });

    test('retries when network error occurs then succeeds on 2nd attempt', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.receiveTimeout,
      );

      final successResponse = Response(
        data: responseData,
        requestOptions: RequestOptions(path: '/test'),
      );

      int callCount = 0;
      when(() =>
          mockApiManager.post(
            endPoint: any(named: 'endPoint'),
            data: any(named: 'data'),
          )).thenAnswer((_) async {
        callCount++;
        if (callCount < 2) {
          throw dioException;
        }
        return successResponse;
      });

      final result = await service.sentMessage(messages);

      expect(result.role, 'model');
      expect(result.parts!.first.text, 'ok');
      verify(() =>
          mockApiManager.post(
            endPoint: any(named: 'endPoint'),
            data: any(named: 'data'),
          )).called(2);
    });

    test('retries when network error occurs then succeeds on 3rd attempt', () async {

      final dioException = DioException(
        requestOptions: RequestOptions(path: '/test'),
        type: DioExceptionType.sendTimeout,
      );

      final successResponse = Response(
        data: responseData,
        requestOptions: RequestOptions(path: '/test'),
      );


      int callCount = 0;
      when(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).thenAnswer((_) async {
        callCount++;
        if (callCount < 3) {
          throw dioException;
        }
        return successResponse;
      });

      final result = await service.sentMessage(messages);

      expect(result.role, 'model');
      expect(result.parts!.first.text, 'ok');
      verify(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).called(3);
    });

    test('retries on all network errors and succeeds on final attempt', () async {

      final networkErrors = [
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.connectionError,
      ];

      final successResponse = Response(
        data: responseData ,
        requestOptions: RequestOptions(path: '/test'),
      );

      int callCount = 0;

      when(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).thenAnswer((_) async {
        callCount++;

        if (callCount <= networkErrors.length) {
          throw DioException(
            requestOptions: RequestOptions(path: '/test'),
            type: networkErrors[callCount - 1],
            response: null,
          );
        }
        return successResponse;
      });

      final result = await service.sentMessage(messages);

      expect(result.role, 'model');
      expect(result.parts!.first.text, 'ok');

      verify(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).called(networkErrors.length + 1);
    });

    test('does not retry on 400 error and throws ServerFailure', () async {

      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          statusCode: 400,
          data: {'message': 'Bad Request'},
          requestOptions: RequestOptions(path: ''),
        ),
        type: DioExceptionType.badResponse,
      );

      when(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).thenThrow(dioException);

      expect(
            () async => await service.sentMessage(messages),
        throwsA(isA<ServerFailure>()),
      );

      // try {
      //   await service.sentMessage(messages);
      //   fail("Should have thrown ServerFailure");
      // } catch (e) {
      //   expect(e, isA<ServerFailure>());
      // }

      verify(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).called(1);
    });

    test('does not retry on 500 error and throws ServerFailure', () async {

      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          statusCode: 500,
          data: {'message': 'Internal Server Error'},
          requestOptions: RequestOptions(path: ''),
        ),
        type: DioExceptionType.badResponse,
      );

      when(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).thenThrow(dioException);

      expect(
            () async => await service.sentMessage(messages),
        throwsA(isA<ServerFailure>()),
      );

      verify(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).called(1);
    });

    test('retries 5 times then throws ServerFailure', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionTimeout,
      );

      when(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).thenAnswer((_) async => throw dioException);

      await expectLater(
            () async => await service.sentMessage(messages),
        throwsA(isA<ServerFailure>()),
      );

      verify(() => mockApiManager.post(
        endPoint: any(named: 'endPoint'),
        data: any(named: 'data'),
      )).called(5);
    });
  });
}