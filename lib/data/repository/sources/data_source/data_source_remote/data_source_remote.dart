import 'package:news_app/test/models/source_response.dart';

abstract class DataSourceRemote {
 Future<SourceResponse> getSources({required String category});
}