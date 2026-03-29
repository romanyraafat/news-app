import 'package:news_app/test/models/api_result.dart';
import 'package:news_app/test/models/articles_response.dart';

abstract class ArtcileRepoContract {
  Future<ApiResult<List<Article>>> getArticles({
    required String category,
    required String source,
  });
}
