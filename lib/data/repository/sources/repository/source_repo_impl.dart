import 'package:news_app/data/repository/sources/data_source/data_source_remote/data_source_remote.dart';
import 'package:news_app/data/repository/sources/repository/source_repo_contract.dart';
import 'package:news_app/test/api/network_exception.dart';
import 'package:news_app/test/models/api_result.dart';
import 'package:news_app/test/models/source_response.dart';

class SourceRepoImpl implements SourceRepoContract {
  final DataSourceRemote dataSourceRemote;

  SourceRepoImpl({required this.dataSourceRemote});
  @override
  Future<ApiResult<List<Source>>> getSources({required String category}) async {
    try {
      var repsonse = await dataSourceRemote.getSources(category: category);
      return Success(repsonse.sources!);
    } catch (error) {
      return Failure(NetworkExceptions.getDioException(error));
    }
  }
}
