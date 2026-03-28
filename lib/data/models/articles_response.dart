

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/data/models/source_response.dart';
part 'articles_response.g.dart';
@JsonSerializable()
class ArticlesResponse {
  String? status;
  int? totalResults;
  List<Article>? articles;

  ArticlesResponse({this.status, this.totalResults, this.articles});

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesResponseToJson(this);
}

@JsonSerializable()
class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
