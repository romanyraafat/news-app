import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/data/api/web_service.dart';
import 'package:news_app/data/repositry/repo.dart';
import 'package:news_app/features/home/view_model/cubit/articles_cubit.dart';
import 'package:news_app/features/home/view_model/cubit/sources_cubit.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void setupLocator() {
    // register Dio
    getIt.registerLazySingleton<Dio>(() => createDio());

    // register WebService
    getIt.registerLazySingleton<WebServcie>(() => WebServcie(getIt<Dio>()));

    // register Repo
    getIt.registerLazySingleton<Repo>(
      () => Repo(webServcie: getIt<WebServcie>()),
    );

    // sources cubit
    getIt.registerFactory<SourcesCubit>(
      () => SourcesCubit(repo: getIt<Repo>()),
    );
    // articles cubit
    getIt.registerFactory<ArticlesCubit>(
      () => ArticlesCubit( getIt<Repo>()),
    );
  }
}

Dio createDio() {
  final dio = Dio();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['x-api-key'] = '957fdcb65f6a4fc195181f86750ebb5c';

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
