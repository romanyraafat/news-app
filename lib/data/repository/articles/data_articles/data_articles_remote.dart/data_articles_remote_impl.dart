import 'package:news_app/data/repository/articles/data_articles/data_articles_remote.dart/data_articles_remote.dart';
import 'package:news_app/test/api/web_service.dart';
import 'package:news_app/test/models/articles_response.dart';

class DataArticlesRemoteImpl implements DataArticlesRemote {
  final WebServcie webServcie;

  DataArticlesRemoteImpl({required this.webServcie});
  @override
  Future<ArticlesResponse> getArticles({
    required String category,
    required String source,
  })async {
    var response = await webServcie.getNews(category, source);
    return response;
  }
}
