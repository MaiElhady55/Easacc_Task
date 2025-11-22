import 'package:easacc_task/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class CacheException extends Equatable implements Exception {
  final String? message;

  const CacheException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class TimeOutException extends ServerException {
  TimeOutException([message]) : super(message ?? LocaleKeys.timeOutError.tr());
}

class NotFoundException extends ServerException {
  NotFoundException([message])
      : super(message ?? LocaleKeys.notFoundError.tr());
}

class ServerErrorException extends ServerException {
  ServerErrorException([message])
      : super(message ?? LocaleKeys.serverError.tr());
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException([message])
      : super(message ?? LocaleKeys.noInternetError.tr());
}

class UnKnownException extends ServerException {
  UnKnownException([message]) : super(message ?? LocaleKeys.unKnownError.tr());
}

class CacheSaveException extends ServerException {
  CacheSaveException([message]) : super(message ?? LocaleKeys.cacheError.tr());
}
