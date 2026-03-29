import 'package:dio/dio.dart';
import 'package:news_app/test/models/articles_response.dart';
import 'package:news_app/test/models/source_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part "web_service.g.dart";

@RestApi(baseUrl: "https://newsapi.org/v2/")
abstract class WebServcie {
  factory WebServcie(Dio dio, {String? baseUrl}) = _WebServcie;

  @GET("top-headlines/sources")
  Future<SourceResponse> getSources(
     @Query("category") String category,
  );
  @GET("everything")
  Future<ArticlesResponse> getNews(
     @Query("q") String category,
     @Query("sources") String source,
  );
}
