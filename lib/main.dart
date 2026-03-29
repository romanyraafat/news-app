import 'package:flutter/material.dart';
import 'package:news_app/utils/service_locator.dart';
import 'features/home/presentation/screens/categories_page.dart';
import 'utils/app_router.dart';

void main() {
  //
    ServiceLocator().setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffFFFFFF)),
        useMaterial3: true,
      ),
      home: const CategoriesPage(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
