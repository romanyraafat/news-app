import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/core/network/exceptions/network_exception.dart';
import 'package:news_app/features/home/data/sources/models/source_response.dart';

part 'sources_state.freezed.dart';

@freezed
class SourcesState with _$SourcesState {
  const factory SourcesState.initial() = _Initial;

  const factory SourcesState.loading() = _Loading;

  const factory SourcesState.success(List<Source> sources) = _Success;

  const factory SourcesState.error(NetworkExceptions message) = _Error;
}
