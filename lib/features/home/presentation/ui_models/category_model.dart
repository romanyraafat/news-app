import 'package:news_app/core/utils/images.dart';

class CategoryModel {
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});
 static List<CategoryModel> categoryModels = [
    CategoryModel( name: 'General', image: Images.general),
    CategoryModel(name: "Entertainment", image:Images.entertainment),
    CategoryModel(name: "Health", image:Images.health),
    CategoryModel(name: "Science", image:Images.science),
    CategoryModel(name: "Sport", image:Images.sport),
    CategoryModel(name: "Technology", image:Images.technology),
    CategoryModel(name: "Money", image:Images.money),
  ];
}