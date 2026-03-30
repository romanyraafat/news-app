import 'package:flutter/material.dart';
import 'package:news_app/features/home/presentation/ui_models/category_model.dart';
import 'package:news_app/features/home/presentation/widgets/category_widget.dart';

class CategroiesPageBody extends StatelessWidget {
  final Function(String category) onTap;

  const CategroiesPageBody({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: CategoryModel.categoryModels.length,
        itemBuilder: (context, index) {
          final category = CategoryModel.categoryModels[index];
          return GestureDetector(
            onTap: () => onTap(category.name),
            child: CategoryWidget(category: category),
          );
        },
      ),
    );
  }
}