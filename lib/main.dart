import 'package:flutter/material.dart';
import 'screens/categories_page.dart';
import 'utils/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
