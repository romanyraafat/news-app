//todo : source repo interface.
import 'package:news_app/test/models/api_result.dart';
import 'package:news_app/test/models/source_response.dart';

abstract class SourceRepoContract {
  Future<ApiResult<List<Source>>> getSources({required String category});
}
