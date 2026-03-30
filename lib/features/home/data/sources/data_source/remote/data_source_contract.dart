import 'package:news_app/features/home/data/sources/models/source_response.dart';

abstract class DataSourceContract {
  Future<SourceResponse> getSources({required String category});
}