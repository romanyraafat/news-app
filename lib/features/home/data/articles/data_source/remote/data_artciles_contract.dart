import 'package:news_app/features/home/data/articles/models/articles_response.dart';

abstract class DataArtcilesContract {
  Future<ArticlesResponse> getArticles({
    required String category,
    required String source,
  });
}
