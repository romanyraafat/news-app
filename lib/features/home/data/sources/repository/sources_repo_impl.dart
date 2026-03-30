import 'package:news_app/core/network/exceptions/network_exception.dart';
import 'package:news_app/core/utils/api_result.dart';
import 'package:news_app/features/home/data/sources/data_source/remote/data_source_contract.dart';
import 'package:news_app/features/home/data/sources/models/source_response.dart';
import 'package:news_app/features/home/data/sources/repository/sources_repo_contract.dart';

class SourcesRepoImpl implements SourcesRepoContract{
  final DataSourceContract dataSourceContract;

  SourcesRepoImpl({required this.dataSourceContract});
  @override
  Future<ApiResult<List<Source>>> getSources({required String category})async {
    try{
      var response = await dataSourceContract.getSources(category: category);
      return Success(response.sources!);
    }catch(error){
      return Failure(NetworkExceptions.getDioException(error));
    }
  }
}