import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/view_model/cubit/sources_cubit.dart';
import 'package:news_app/features/home/presentation/widgets/category_details_view.dart';
import 'package:news_app/core/di/service_locator.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String category;

  const CategoryDetailsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SourcesCubit>()..getSources(category: category),
      child: CategoryDetailsView(category: category),
    );
  }
}

