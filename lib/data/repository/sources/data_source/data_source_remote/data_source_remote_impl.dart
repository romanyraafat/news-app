import 'package:news_app/data/repository/sources/data_source/data_source_remote/data_source_remote.dart';
import 'package:news_app/test/api/web_service.dart';
import 'package:news_app/test/models/source_response.dart';

class DataSourceRemoteImpl implements DataSourceRemote {
  final WebServcie webServcie;
  DataSourceRemoteImpl({required this.webServcie});

  @override
  Future<SourceResponse> getSources({required String category}) async {
    var response = await webServcie.getSources(category);
    return response;
  }
}
