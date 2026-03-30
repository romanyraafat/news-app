import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/core/network/exceptions/network_exception.dart';
import 'package:news_app/features/home/data/articles/models/articles_response.dart';


part 'articles_state.freezed.dart';

@freezed
class ArticlesState with _$ArticlesState {
  const factory ArticlesState.initial() = _Initial;

  const factory ArticlesState.loading() = _Loading;

  const factory ArticlesState.success(List<Article> sources) = _Success;

  const factory ArticlesState.error(NetworkExceptions message) = _Error;
}
