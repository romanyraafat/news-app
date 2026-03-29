import 'package:news_app/test/api/network_exception.dart';
import 'package:news_app/test/api/web_service.dart';
import 'package:news_app/test/models/api_result.dart';
import 'package:news_app/test/models/articles_response.dart';
import 'package:news_app/test/models/source_response.dart';

class Repo {
  final WebServcie webServcie;

  Repo({required this.webServcie});
  Future<ApiResult<List<Source>>> getSources({required String category}) async {
    try {
      var response = await webServcie.getSources(category);
      return Success(response.sources!);
    } catch (e) {
      return Failure(NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List<Article>>> getArticles({
    required String category,
    required String source,
  }) async {
    try {
      var response = await webServcie.getNews(category, source);
      return Success(response.articles!);
    } catch (e) {
      return Failure(NetworkExceptions.getDioException(e));
    }
  }
}
