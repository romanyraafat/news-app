import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/test/models/error_model.dart';
// import 'package:news_app/data/models/error_model.dart';

part 'network_exception.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.parsingException() = ParsingException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    final statusCode = response?.statusCode ?? 0;
    final data = response?.data;

    String errorReason = '';

    // Safely parse error messages from response
    if (data is List) {
      try {
        final listOfErrors = List.from(data)
            .map((e) {
              try {
                return ErrorModel.fromJson(e).message;
              } catch (_) {
                return null;
              }
            })
            .whereType<String>()
            .toList();
        errorReason = listOfErrors.join(' | ');
      } catch (_) {}
    } else if (data is Map<String, dynamic>) {
      errorReason =
          data['message']?.toString() ?? data['error']?.toString() ?? '';
    } else if (data is String) {
      errorReason = data;
    }

    errorReason = errorReason.replaceAll("(", "").replaceAll(")", "").trim();
    if (errorReason.isEmpty) {
      errorReason = 'Request failed';
    }

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return NetworkExceptions.unauthorizedRequest(errorReason);
      case 404:
        return NetworkExceptions.notFound(
          errorReason.isEmpty ? 'Resource not found' : errorReason,
        );
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
        return NetworkExceptions.unprocessableEntity(errorReason);
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        return NetworkExceptions.defaultError('HTTP $statusCode: $errorReason');
    }
  }

  static NetworkExceptions getDioException(error) {
    // لو دي SocketException مباشرة
    if (error is SocketException) {
      return const NetworkExceptions.noInternetConnection();
    }

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return const NetworkExceptions.requestCancelled();
        case DioExceptionType.connectionTimeout:
          return const NetworkExceptions.requestTimeout();
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return const NetworkExceptions.sendTimeout();
        case DioExceptionType.badResponse:
          return NetworkExceptions.handleResponse(error.response);
        case DioExceptionType.unknown:
          // لو جوه unknown في SocketException
          if (error.error is SocketException) {
            return const NetworkExceptions.noInternetConnection();
          }
          // لو string error فيه كلمات معروفة للشبكة
          final errorString = error.error?.toString().toLowerCase() ?? '';
          final messageString = error.message?.toLowerCase() ?? '';
          if (errorString.contains('socket') ||
              errorString.contains('failed host lookup') ||
              errorString.contains('connection refused') ||
              errorString.contains('network is unreachable') ||
              errorString.contains('connection failed') ||
              errorString.contains('no route to host') ||
              messageString.contains('socket') ||
              messageString.contains('network') ||
              messageString.contains('connection')) {
            return const NetworkExceptions.noInternetConnection();
          }
          return const NetworkExceptions.unexpectedError();
        default:
          return const NetworkExceptions.unexpectedError();
      }
    }

    // fallback
    return const NetworkExceptions.unexpectedError();
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(
      notImplemented: () {
        errorMessage = "Not Implemented";
      },
      requestCancelled: () {
        errorMessage = "Request Cancelled";
      },
      internalServerError: () {
        errorMessage = "Internal Server Error";
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = "Service unavailable";
      },
      methodNotAllowed: () {
        errorMessage = "Method Allowed";
      },
      badRequest: () {
        errorMessage = "you must write id of user";
      },
      unauthorizedRequest: (String error) {
        errorMessage = error;
      },
      unprocessableEntity: (String error) {
        errorMessage = error;
      },
      unexpectedError: () {
        errorMessage = "No internet connection";
      },
      requestTimeout: () {
        errorMessage = "Connection request timeout";
      },
      noInternetConnection: () {
        errorMessage = "No internet connection";
      },
      conflict: () {
        errorMessage = "Error due to a conflict";
      },
      sendTimeout: () {
        errorMessage = "Send timeout in connection with API server";
      },
      unableToProcess: () {
        errorMessage = "Unable to process the data";
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      parsingException: () {
        errorMessage = "Unexpected error occurred";
      },
      notAcceptable: () {
        errorMessage = "Not acceptable";
      },
    );
    return errorMessage;
  }
}