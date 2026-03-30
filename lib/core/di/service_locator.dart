import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/network/web_service/web_service.dart';
import 'package:news_app/features/home/data/articles/data_source/remote/data_artciles_contract.dart';
import 'package:news_app/features/home/data/articles/data_source/remote/data_articles_impl.dart';
import 'package:news_app/features/home/data/articles/repository/articles_repo_contract.dart';
import 'package:news_app/features/home/data/articles/repository/articles_repo_impl.dart';
import 'package:news_app/features/home/data/sources/data_source/remote/data_source_contract.dart';
import 'package:news_app/features/home/data/sources/data_source/remote/data_source_impl.dart';
import 'package:news_app/features/home/data/sources/repository/sources_repo_contract.dart';
import 'package:news_app/features/home/data/sources/repository/sources_repo_impl.dart';
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
    getIt.registerLazySingleton<DataSourceContract>(
      () => DataSourceImpl(webServcie: getIt<WebServcie>()),
    );

    // 4️⃣ Repositories
    getIt.registerLazySingleton<SourcesRepoContract>(
      () => SourcesRepoImpl(dataSourceContract: getIt<DataSourceContract>()),
    );

    // 6 Cubits / Blocs
    getIt.registerFactory<SourcesCubit>(
      () => SourcesCubit(repo: getIt<SourcesRepoContract>()),
    );
    
    // 4 Remote DataSource
    getIt.registerLazySingleton<DataArtcilesContract>(
      () => DataArticlesImpl(webServcie: getIt<WebServcie>()),
    );

    // 5 Repositories
    getIt.registerLazySingleton<ArticlesRepoContract>(
      () => ArticlesRepoImpl(dataArtcilesContract: getIt<DataArtcilesContract>()),
    );


    // 7 Cubits / Blocs
    getIt.registerFactory<ArticlesCubit>(
      () => ArticlesCubit(getIt<ArticlesRepoContract>()),
    );
  }
}

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
