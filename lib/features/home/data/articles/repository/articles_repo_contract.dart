import 'package:news_app/core/utils/api_result.dart';
import 'package:news_app/features/home/data/articles/models/articles_response.dart';

abstract class ArticlesRepoContract {
  Future<ApiResult<List<Article>>> getArticles({
    required String category,
    required String source,
  });
}
