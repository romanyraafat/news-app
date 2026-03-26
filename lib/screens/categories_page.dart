import 'package:flutter/material.dart';
import 'package:news_app/screens/category_details_page.dart';
import 'package:news_app/widgets/categroies_page_body.dart';
import 'package:news_app/widgets/custom_drawer.dart';



class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        title: Text(selectedCategory ?? 'News App'),
        centerTitle: true,
        backgroundColor: Color(0xffffffff),
        actions: [IconButton(onPressed: (){}, icon:Icon( Icons.search)),],
        // leading: IconButton(onPressed: (){}, icon:Icon( Icons.search)),
      ),
      drawer: buildDrawer(context, () {
        setState(() {
          selectedCategory = null;
        });
      }),
      body: selectedCategory == null
          ? CategroiesPageBody(
              onTap: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            )
          : CategoryDetailsPage(category: selectedCategory!),
    );
  }
}
