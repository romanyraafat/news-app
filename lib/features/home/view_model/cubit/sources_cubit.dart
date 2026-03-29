

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/repository/sources/repository/source_repo_contract.dart';
import 'package:news_app/test/models/api_result.dart';
import 'package:news_app/features/home/view_model/cubit/sources_state.dart';

class SourcesCubit extends Cubit<SourcesState> {
  final SourceRepoContract repo;
  SourcesCubit({required this.repo}) : super(SourcesState.initial());
  Future<void> getSources({required String category})async
  {
    emit(SourcesState.loading());
    var response = await repo.getSources(category: category);
    response.when(success: (sources){
      emit(SourcesState.success(sources));
    }, failure: (error){
      emit(SourcesState.error(error));
    });
  }
}
// class SourcesCubit extends Cubit<SourcesState> {
//   final Repo repo;
//   SourcesCubit({required this.repo}) : super(SourcesState.initial());
//   Future<void> getSources({required String category})async
//   {
//     emit(SourcesState.loading());
//     var response = await repo.getSources(category: category);
//     response.when(success: (sources){
//       emit(SourcesState.success(sources));
//     }, failure: (error){
//       emit(SourcesState.error(error));
//     });
//   }
// }
