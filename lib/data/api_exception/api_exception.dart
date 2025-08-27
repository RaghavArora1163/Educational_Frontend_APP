// ignore_for_file: prefer_typing_uninitialized_variables

class AppException implements Exception{
  final _prefix;
  final _message;

  AppException([this._message,this._prefix]);

  @override
  String toString(){
    return '$_prefix$_message';
  }
}

class InternetException extends AppException{
  InternetException([String? message]) : super(message, 'No Internet');
}

class RequestTimeOutException extends AppException{
  RequestTimeOutException([String? message]) : super(message, 'Request Time Out');
}

class ServerException extends AppException{
  ServerException([String? message]) : super(message, 'Internal Server Exception');
}

class InvalidUrlException extends AppException{
  InvalidUrlException() : super('Invalid Url');
}

class OtherException extends AppException{
  OtherException() : super('Other Exception');
}