// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/data/products/product_service.dart';
import 'package:get_practise/app/modules/home/Models/products_model.dart';
import 'package:get_practise/app/modules/home/views/category.dart';
import 'package:get_practise/app/modules/home/views/fav.dart';
import 'package:get_practise/app/modules/home/views/home.dart';
import 'package:get_practise/app/modules/home/views/setting.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final index = 0.obs;
  final smoothIndecatorIndex = 0.obs;
  int clothSizeIndex = 0;
  var productsList = <ProductsModel>[].obs;
  var categoryDetailsList = <ProductsModel>[].obs;
  var isLoading = true.obs;
  var categoryNameList = <String>[].obs;
  var searchList = <ProductsModel>[].obs;
  var favList = <ProductsModel>[].obs;
  var cartMap = {}.obs;
  var searchController = TextEditingController();
  var storage = GetStorage();
  var darkSwitch = false.obs;

  void clothSize(int index) {
    clothSizeIndex = index;
    update();
  }

  void smoothIndecator(int index) {
    smoothIndecatorIndex.value = index;
    update();
  }

  var screens = [
    Home(),
    const Categories(),
    const Favorite(),
    Setting(),
  ].obs;
  var appBarTitle = [
    'Home',
    'Categroy',
    'Favorite',
    'Settings',
  ].obs;

  void getData() async {
    var data = await ProductServices.getProducts();
    try {
      isLoading(true);
      if (data.isNotEmpty) {
        productsList.addAll(data);
      }
    } finally {
      isLoading(false);
    }
  }

  void getCategories() async {
    var data = await ProductServices.getCategory();
    isLoading(true);
    try {
      if (data.isNotEmpty) {
        categoryNameList.addAll(data);
      }
    } finally {
      isLoading(false);
    }
  }

  getAllCategorys(String namecategory) async {
    isLoading(true);
    categoryDetailsList.value =
        await ProductServices.getCategoriesDetails(namecategory);
    isLoading(false);
  }

  getCategoryIndex(int index) async {
    var categoryAlIName = await getAllCategorys(categoryNameList[index]);
    if (categoryAlIName != null) {
      categoryDetailsList.value = categoryAlIName;
    }
  }

  void addToSearchList(String searchName) {
    searchList.value = productsList
        .where((search) => search.title.toLowerCase().contains(searchName))
        .toList();
    update();
  }

  void clearSearch() {
    searchController.clear();
    searchList.value = [];
    update();
  }

  void addToFavorite(int productId) {
    int isIndex = favList.indexWhere((element) => element.id == productId);
    if (isIndex >= 0) {
      favList.removeAt(isIndex);
      storage.remove('FavoriteList');
    } else {
      favList
          .add(productsList.firstWhere((element) => element.id == productId));
      storage.write('FavoriteList', favList);
    }
  }

  bool isFavorite(int productId) {
    return favList.any((element) => element.id == productId);
  }

  void addToCart(ProductsModel model) {
    if (cartMap.containsKey(model)) {
      cartMap[model] += 1;
    } else {
      cartMap[model] = 1;
    }
  }

  void removeFromCart(ProductsModel model) {
    if (cartMap.containsKey(model) && cartMap[model] == 1) {
      cartMap.removeWhere((key, value) => key == model);
    } else {
      cartMap[model] -= 1;
    }
  }

  void removeOneItemFromCart(ProductsModel model) {
    cartMap.removeWhere((key, value) => key == model);
  }

  get subTotal => cartMap.entries.map((e) => e.key.price * e.value).toList();
  get total => cartMap.entries
      .map((e) => e.key.price * e.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  bool isExist = false;
  setIsExist() {
    isExist = true;
    update();
  }

  var ar = 'ar';
  var en = 'en';

  void dropDownChangeMenu(value) {
    update();
  }

  @override
  void onInit() {
    getData();
    getCategories();
    List? favoriteList = storage.read<List>('FavoriteList');
    if (favoriteList != null) {
      favList = favoriteList.map((e) => ProductsModel.fromJson(e)).toList().obs;
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
