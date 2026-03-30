import 'package:news_app/core/network/web_service/web_service.dart';
import 'package:news_app/features/home/data/sources/data_source/remote/data_source_contract.dart';
import 'package:news_app/features/home/data/sources/models/source_response.dart';

class DataSourceImpl implements DataSourceContract{
  final WebServcie webServcie;

  DataSourceImpl({required this.webServcie});
  @override
  Future<SourceResponse> getSources({required String category})async {
    var response = await webServcie.getSources(category);
    return response; 
  }
}