import 'package:news_app/core/utils/api_result.dart';
import 'package:news_app/features/home/data/sources/models/source_response.dart';

abstract class SourcesRepoContract {
  Future<ApiResult<List<Source>>> getSources({required String category});
}