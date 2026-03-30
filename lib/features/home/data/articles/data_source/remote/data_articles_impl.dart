import 'package:news_app/core/network/web_service/web_service.dart';
import 'package:news_app/features/home/data/articles/data_source/remote/data_artciles_contract.dart';
import 'package:news_app/features/home/data/articles/models/articles_response.dart';

class DataArticlesImpl implements DataArtcilesContract {
  final WebServcie webServcie;

  DataArticlesImpl({required this.webServcie});
  @override
  Future<ArticlesResponse> getArticles({
    required String category,
    required String source,
  }) async {
    var response = await webServcie.getNews(category, source);
    return response;
  }
}
