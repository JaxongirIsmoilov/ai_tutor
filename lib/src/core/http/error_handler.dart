import 'package:ai_tutor/src/core/http/string_manager.dart';
import 'package:dio/dio.dart';
import 'failure.dart';


class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
      case DioExceptionType.unknown:
      return DataSource.UNAUTORISED.getFailure();
    case DioExceptionType.badResponse:
    if(error.response?.statusCode == 401){
      return DataSource.UNAUTORISED.getFailure();
    }
    if(error.response?.statusCode == 500){
      return DataSource.INTERNAL_SERVER_ERROR.getFailure();
    }
    if(error.response?.statusCode == 502){
      return DataSource.SERVER_ERROR.getFailure();
    }
    if(error.response?.statusCode == 403){
      return DataSource.FORBIDDEN.getFailure();
    }
    if(error.response?.statusCode == 404){
      return DataSource.NOT_FOUND.getFailure();
    }
    return DataSource.UNAUTORISED.getFailure();
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    default:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
  SERVER_ERROR
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);
        case DataSource.SERVER_ERROR:
        return Failure(ResponseCode.SERVER_ERROR, ResponseMessage.SERVER_ERROR);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int UNAUTORISED = 401;
  static const int FORBIDDEN = 403;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int NOT_FOUND = 404;
  static const int SERVER_ERROR = 502;

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static  String SUCCESS = NetworkMessages.success;
  static  String NO_CONTENT = NetworkMessages.success;
  static  String BAD_REQUEST = NetworkMessages.strBadRequestError;
  static  String UNAUTORISED = NetworkMessages.strUnauthorizedError;
  static  String FORBIDDEN = NetworkMessages.strForbiddenError;
  static  String INTERNAL_SERVER_ERROR = NetworkMessages.strInternalServerError;
  static  String NOT_FOUND = NetworkMessages.strNotFoundError;
  static  String SERVER_ERROR = NetworkMessages.strServerError;

  // local status code
  static  String CONNECT_TIMEOUT = NetworkMessages.strTimeoutError;
  static  String CANCEL = NetworkMessages.strDefaultError;
  static  String RECIEVE_TIMEOUT = NetworkMessages.strTimeoutError;
  static  String SEND_TIMEOUT = NetworkMessages.strTimeoutError;
  static  String CACHE_ERROR = NetworkMessages.strCacheError;
  static  String NO_INTERNET_CONNECTION = NetworkMessages.strNoInternetError;
  static  String DEFAULT = NetworkMessages.strUnauthorizedError;
}

class ApiInternalStatus {
  static const int SUCCESS = 200;
  static const int FAILURE = 400;
}
