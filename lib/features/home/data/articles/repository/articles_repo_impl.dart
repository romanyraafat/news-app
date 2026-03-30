import 'package:news_app/core/network/exceptions/network_exception.dart';
import 'package:news_app/core/utils/api_result.dart';
import 'package:news_app/features/home/data/articles/data_source/remote/data_artciles_contract.dart';
import 'package:news_app/features/home/data/articles/models/articles_response.dart';
import 'package:news_app/features/home/data/articles/repository/articles_repo_contract.dart';

class ArticlesRepoImpl implements ArticlesRepoContract{
  final DataArtcilesContract dataArtcilesContract;

  ArticlesRepoImpl({required this.dataArtcilesContract});
  @override
  Future<ApiResult<List<Article>>> getArticles({required String category, required String source})async {
    try{
      var response = await dataArtcilesContract.getArticles(category: category, source: source);
      return Success(response.articles!);
    }catch(error){
      return Failure(NetworkExceptions.getDioException(error));
    }
  }
}