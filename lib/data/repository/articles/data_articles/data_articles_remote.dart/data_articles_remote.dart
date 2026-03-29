import 'package:news_app/test/models/articles_response.dart';

abstract class DataArticlesRemote {
   Future<ArticlesResponse> getArticles({required String category ,required String source});

}