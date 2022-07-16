import 'package:wallpapers/model/categories_model.dart';

String apiKey = "563492ad6f91700001000001d994d83af0b84fcb8161b2778f50cacd";

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];
  CategoriesModel categorieModel = CategoriesModel();

  categorieModel.categorieName = "Street Art";
  categorieModel.imgUrl = "https://wallpapercave.com/wp/wp3559845.jpg";
  categories.add(categorieModel);
  categorieModel = CategoriesModel();

  categorieModel.categorieName = "Space";
  categorieModel.imgUrl = "https://wallpapercave.com/dwp1x/wp10856122.jpg";
  categories.add(categorieModel);
  categorieModel = CategoriesModel();

  categorieModel.categorieName = "Abstract";
  categorieModel.imgUrl = "https://wallpapercave.com/dwp1x/wp11197005.jpg";
  categories.add(categorieModel);
  categorieModel = CategoriesModel();

  categorieModel.categorieName = "Anime";
  categorieModel.imgUrl = "https://wallpapercave.com/dwp1x/wp5174779.jpg";
  categories.add(categorieModel);
  categorieModel = CategoriesModel();

  categorieModel.categorieName = "Coding";
  categorieModel.imgUrl = "https://wallpapercave.com/dwp1x/wp7692192.jpg";
  categories.add(categorieModel);
  categorieModel = CategoriesModel();

  return categories;
}
