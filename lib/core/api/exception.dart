class ExceptionMessages {
  static const ERROR_CONNECTIVITY_MESSAGE =
      "Проблема с интернет-соединением, попробуйте еще раз";
  static const ERROR_UNKNOWN_MESSAGE =
      "Неизвестная ошибка, пожалуйста, попробуйте позже";
  static const ERROR_NO_SUCH_METHOD_MESSAGE =
      "Данные были отправлены некорретно, пожалуйста перезайдите на страницу еще раз";
  static const ERROR_TOKEN_EXPIRED =
      "Доступ закрыт. Попробуйте войти в приложение заново";
  static const ERROR_NO_DATA =
      "Необходимые данные не могут быть получены, попробуйте позже";
}

class ExceptionModel implements Exception {
  final String? msg;
  final int? code;

  ExceptionModel([this.msg, this.code]);

  @override
  String toString() {
    return 'ExceptionModel{msg: $msg, code: $code}';
  }

  String? toUserString() {
    return msg;
  }
}

class UnknownException extends ExceptionModel {
  static const String DEFAULT_MESSAGE = ExceptionMessages.ERROR_UNKNOWN_MESSAGE;
  static const int DEFAULT_CODE = 2;

  UnknownException() : super(DEFAULT_MESSAGE, DEFAULT_CODE);

  @override
  String toString() =>
      'UnknownException { code: $DEFAULT_CODE, message: $DEFAULT_MESSAGE }';
}

class NoSuchMethodError extends ExceptionModel {
  static const String DEFAULT_MESSAGE =
      ExceptionMessages.ERROR_NO_SUCH_METHOD_MESSAGE;
  static const int DEFAULT_CODE = 5;

  NoSuchMethodError() : super(DEFAULT_MESSAGE, DEFAULT_CODE);

  @override
  String toString() =>
      'NoSuchMethodError { code: $DEFAULT_CODE, message: $DEFAULT_MESSAGE }';
}

class ConnectivityException extends ExceptionModel {
  static const String DEFAULT_MESSAGE =
      ExceptionMessages.ERROR_CONNECTIVITY_MESSAGE;
  static const int DEFAULT_CODE = 1;

  ConnectivityException() : super(DEFAULT_MESSAGE, DEFAULT_CODE);

  @override
  String toString() =>
      'ConnectivityException { code: $DEFAULT_CODE, message: $DEFAULT_MESSAGE }';
}

class NoDataException extends ExceptionModel {
  static const String DEFAULT_MESSAGE = ExceptionMessages.ERROR_NO_DATA;
  static const int DEFAULT_CODE = 100;

  NoDataException() : super(DEFAULT_MESSAGE, DEFAULT_CODE);

  @override
  String toString() =>
      'NoDataException { code: $DEFAULT_CODE, message: $DEFAULT_MESSAGE }';
}

class ErrorException extends ExceptionModel {
  final String? msg;
  static const int DEFAULT_CODE = 3;

  ErrorException({this.msg}) : super(msg, DEFAULT_CODE);

  @override
  String toString() => 'ErrorException { code: $DEFAULT_CODE, message: $msg }';
}

class TokenExpiredException extends ExceptionModel {
  static const String DEFAULT_MESSAGE = ExceptionMessages.ERROR_TOKEN_EXPIRED;
  static const int DEFAULT_CODE = 1;

  TokenExpiredException() : super(DEFAULT_MESSAGE, DEFAULT_CODE);

  @override
  String toString() =>
      'TokenExpiredException { code: $DEFAULT_CODE, message: $DEFAULT_MESSAGE }';
}
