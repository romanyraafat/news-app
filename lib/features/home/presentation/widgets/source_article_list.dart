import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/api/network_exception.dart';
import 'package:news_app/data/models/source_response.dart';
import 'package:news_app/data/repositry/repo.dart';
import 'package:news_app/features/home/view_model/cubit/articles_cubit.dart';
import 'package:news_app/features/home/view_model/cubit/articles_state.dart';
import 'package:news_app/features/home/presentation/widgets/article_details.dart';
import 'package:news_app/utils/service_locator.dart';

class SourceArticleList extends StatelessWidget {
  final String category;
  final Source source;

  const SourceArticleList({
    super.key,
    required this.source,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    /// guard ضد null id
    if (source.id == null) {
      return const Center(
        child: Text("Invalid source"),
      );
    }

    return BlocProvider(
      create: (context) => ArticlesCubit(getIt<Repo>())
        ..getArticles(
          category: category,
          source: source.id!,
        ),
      child: BlocBuilder<ArticlesCubit, ArticlesState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              return const SizedBox();
            },

            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },

            success: (articles) {
              /// empty list case
              if (articles.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "No articles available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ArticleDetails(
                    article: articles[index],
                  );
                },
              );
            },

            error: (error) {
              return Center(
                child: Text(
                  NetworkExceptions.getErrorMessage(error),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
