import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/api/network_exception.dart';
import 'package:news_app/features/home/view_model/cubit/sources_cubit.dart';
import 'package:news_app/features/home/view_model/cubit/sources_state.dart';
import 'package:news_app/features/home/presentation/widgets/source_article_list.dart';

class CategoryDetailsView extends StatefulWidget {
  final String category;

  const CategoryDetailsView({super.key, required this.category});

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SourcesCubit, SourcesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: Text("Start")),

          loading: () => const Center(child: CircularProgressIndicator()),

          success: (sources) {
            tabController ??= TabController(
              length: sources.length,
              vsync: this,
            );

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  title: Container(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      controller: tabController,
                      isScrollable: true,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ), //
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                      tabs: sources.map((e) => Tab(text: e.name)).toList(),
                    ),
                  ),
                ),

                SliverFillRemaining(
                  child: TabBarView(
                    controller: tabController,
                    children: sources
                        .map(
                          (source) => SourceArticleList(
                            category:widget.category ,
                            source: source,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          },

          error: (error) =>
              Center(child: Text(NetworkExceptions.getErrorMessage(error))),
        );
      },
    );
  }
}
