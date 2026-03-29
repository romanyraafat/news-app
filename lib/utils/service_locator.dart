import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/data/repository/articles/data_articles/data_articles_remote.dart/data_articles_remote.dart';
import 'package:news_app/data/repository/articles/data_articles/data_articles_remote.dart/data_articles_remote_impl.dart';
import 'package:news_app/data/repository/repository/artcile_repo_contract.dart';
import 'package:news_app/data/repository/repository/article_repo_impl.dart';
import 'package:news_app/data/repository/sources/data_source/data_source_remote/data_source_remote.dart';
import 'package:news_app/data/repository/sources/data_source/data_source_remote/data_source_remote_impl.dart';
import 'package:news_app/data/repository/sources/repository/source_repo_contract.dart';
import 'package:news_app/data/repository/sources/repository/source_repo_impl.dart';
import 'package:news_app/test/api/web_service.dart';
import 'package:news_app/test/repositry/repo.dart';
import 'package:news_app/features/home/view_model/cubit/articles_cubit.dart';
import 'package:news_app/features/home/view_model/cubit/sources_cubit.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void setupLocator() {
    // 1️⃣ Dio
    getIt.registerLazySingleton<Dio>(() => createDio());

    // 2️⃣ WebService
    getIt.registerLazySingleton<WebServcie>(() => WebServcie(getIt<Dio>()));

    // 3️⃣ Remote DataSource
    getIt.registerLazySingleton<DataSourceRemote>(
      () => DataSourceRemoteImpl(webServcie: getIt<WebServcie>()),
    );

    // 4️⃣ Repositories
    getIt.registerLazySingleton<SourceRepoContract>(
      () => SourceRepoImpl(dataSourceRemote: getIt<DataSourceRemote>()),
    );
    
    // 3️⃣ Remote DataSource
    getIt.registerLazySingleton<DataArticlesRemote>(
      () => DataArticlesRemoteImpl(webServcie: getIt<WebServcie>()),
    );

    // 4️⃣ Repositories
    getIt.registerLazySingleton<ArtcileRepoContract>(
      () => ArticleRepoImpl(dataSource: getIt<DataArticlesRemote>()),
    );
    
    // // last repo
    // getIt.registerLazySingleton<Repo>(
    //   () => Repo(webServcie: getIt<WebServcie>()),
    // );

    // 5️⃣ Cubits / Blocs
    getIt.registerFactory<SourcesCubit>(
      () => SourcesCubit(repo: getIt<SourceRepoContract>()),
    );

    getIt.registerFactory<ArticlesCubit>(() => ArticlesCubit(getIt<ArtcileRepoContract>()));
  }
}
// class ServiceLocator {
//   void setupLocator() {
//     // register Dio
//     getIt.registerLazySingleton<Dio>(() => createDio());

//     // register WebService
//     getIt.registerLazySingleton<WebServcie>(() => WebServcie(getIt<Dio>()));

//     // register Repo
//     getIt.registerLazySingleton<Repo>(
//       () => Repo(webServcie: getIt<WebServcie>()),
//     );

//     // sources cubit
//     getIt.registerFactory<SourcesCubit>(
//       () => SourcesCubit(repo: getIt<Repo>()),
//     );
//     // // sources cubit
//     // getIt.registerFactory<SourcesCubit>(
//     //   () => SourcesCubit(repo: getIt<Repo>()),
//     // );
//     // articles cubit
//     getIt.registerFactory<ArticlesCubit>(
//       () => ArticlesCubit( getIt<Repo>()),
//     );
//   }
// }

Dio createDio() {
  final dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['x-api-key'] = 'b85b2836c49a479d9c7d70d05e8b2f29';

        return handler.next(options); // مهم جدًا
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ),
  );

  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ),
  );

  return dio;
}
