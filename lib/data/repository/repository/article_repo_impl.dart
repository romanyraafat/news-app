import 'package:news_app/data/repository/articles/data_articles/data_articles_remote.dart/data_articles_remote.dart';
import 'package:news_app/data/repository/repository/artcile_repo_contract.dart';
import 'package:news_app/test/api/network_exception.dart';
import 'package:news_app/test/models/api_result.dart';
import 'package:news_app/test/models/articles_response.dart';

class ArticleRepoImpl implements ArtcileRepoContract {
  final DataArticlesRemote dataSource;

  ArticleRepoImpl({required this.dataSource});
  @override
  Future<ApiResult<List<Article>>> getArticles({
    required String category,
    required String source,
  }) async {
    try {
      var response = await dataSource.getArticles(
        category: category,
        source: source,
      );
      return Success(response.articles!);
    } catch (error) {
      return Failure(NetworkExceptions.getDioException(error));
    }
  }
}
