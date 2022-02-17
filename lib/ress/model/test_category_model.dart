import 'package:pharmacy/ress/utils/static_assets_path.dart';

class TestCategoryModel {
  String titel;
  String imagePath;
  TestCategoryModel({
    required this.titel,
    required this.imagePath,
  });

  static List<TestCategoryModel> getCategoryList() {
    return [
      TestCategoryModel(
        titel: "General",
        imagePath: StaticImagePath.rootPath + "general.png",
      ),
      TestCategoryModel(
        titel: "ENT",
        imagePath: StaticImagePath.rootPath + "ent.png",
      ),
      TestCategoryModel(
        titel: "Dermatology",
        imagePath: StaticImagePath.rootPath + "dermatology.png",
      ),
      TestCategoryModel(
        titel: "Gastroenterology",
        imagePath: StaticImagePath.rootPath + "gastroenterology.png",
      ),
      TestCategoryModel(
        titel: "Neurology",
        imagePath: StaticImagePath.rootPath + "neurology.png",
      ),
      TestCategoryModel(
        titel: "Gynaecology",
        imagePath: StaticImagePath.rootPath + "gynaecology.png",
      ),
      TestCategoryModel(
        titel: "General",
        imagePath: StaticImagePath.rootPath + "general.png",
      ),
      TestCategoryModel(
        titel: "ENT",
        imagePath: StaticImagePath.rootPath + "ent.png",
      ),
      TestCategoryModel(
        titel: "Dermatology",
        imagePath: StaticImagePath.rootPath + "dermatology.png",
      ),
      TestCategoryModel(
        titel: "Gastroenterology",
        imagePath: StaticImagePath.rootPath + "gastroenterology.png",
      ),
      TestCategoryModel(
        titel: "Neurology",
        imagePath: StaticImagePath.rootPath + "neurology.png",
      ),
      TestCategoryModel(
        titel: "Gynaecology",
        imagePath: StaticImagePath.rootPath + "gynaecology.png",
      ),
    ];
  }
}
