import 'package:get_practise/app/components/componants.dart';
import 'package:get_practise/app/modules/home/Models/products_model.dart';
import 'package:http/http.dart' as http;

import '../../modules/home/Models/category_model.dart';

class ProductServices {
  static Future<List<ProductsModel>> getProducts() async {
    var response = await http.get(Uri.parse('${Components.BASEURL}/products'));
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return productsModelFromJson(jsonData);
    } else {
      throw Exception('Products Load of API failed');
    }
  }

  static Future<List<String>> getCategory() async {
    var response =
        await http.get(Uri.parse('${Components.BASEURL}/products/categories'));
    if (response.statusCode == 200) {
      var data = response.body;
      return categoryModelFromJson(data);
    } else {
      throw Exception('Category Load of API failed');
    }
  }

  static Future<List<ProductsModel>> getCategoriesDetails(
      String categoryName) async {
    var response = await http.get(
        Uri.parse('${Components.BASEURL}/products/category/$categoryName'));
    if (response.statusCode == 200) {
      var data = response.body;
      return productsModelFromJson(data);
    } else {
      throw Exception('Category details Load of API failed');
    }
  }
}
