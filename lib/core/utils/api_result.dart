import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/core/network/exceptions/network_exception.dart';
part 'api_result.freezed.dart';
@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;

  const factory ApiResult.failure(NetworkExceptions error) = Failure<T>;
}
