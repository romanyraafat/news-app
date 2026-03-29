import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/repository/repository/artcile_repo_contract.dart';
import 'package:news_app/test/models/api_result.dart';
import 'package:news_app/features/home/view_model/cubit/articles_state.dart';


class ArticlesCubit extends Cubit<ArticlesState> {
  final ArtcileRepoContract repo;
  ArticlesCubit(this.repo) : super(ArticlesState.initial());
  Future<void> getArticles({required String category , required String source})async
  {
    emit(ArticlesState.loading());
    var response = await repo.getArticles(category: category, source: source);
    response.when(success: (success){
      emit(ArticlesState.success(success));
    }, failure: (failure){
      emit(ArticlesState.error(failure));
    });
  }
}
// class ArticlesCubit extends Cubit<ArticlesState> {
//   final Repo repo;
//   ArticlesCubit(this.repo) : super(ArticlesState.initial());
//   Future<void> getArticles({required String category , required String source})async
//   {
//     emit(ArticlesState.loading());
//     var response = await repo.getArticles(category: category, source: source);
//     response.when(success: (success){
//       emit(ArticlesState.success(success));
//     }, failure: (failure){
//       emit(ArticlesState.error(failure));
//     });
//   }
// }
