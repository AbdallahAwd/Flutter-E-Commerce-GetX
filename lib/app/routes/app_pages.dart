// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:get_practise/app/modules/auth/binding/auth_binding.dart';
import 'package:get_practise/app/modules/auth/views/auth_view.dart';
import 'package:get_practise/app/modules/auth/views/sign_up_view.dart';
import 'package:get_practise/app/modules/home/bindings/home_binding.dart';
import 'package:get_practise/app/modules/home/views/cart.dart';
import 'package:get_practise/app/modules/home/views/search.dart';

import '../modules/home/views/cat_list.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(name: Paths.AUTH, page: () => AuthView(), binding: AuthBinding()),
    GetPage(
      name: Paths.HOME,
      page: () => const HomeView(),
      transition: Transition.rightToLeft,
      binding: HomeBinding(),
    ),
    GetPage(
      name: Paths.SIGNUP,
      page: () => SignUpView(),
      transition: Transition.rightToLeft,
      binding: AuthBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Paths.CategoryDETAILS,
      page: () => const CatList(),
      transition: Transition.rightToLeft,
      binding: AuthBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Paths.SEARCH,
      page: () => const Search(),
      transition: Transition.rightToLeft,
      binding: AuthBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Paths.CART,
      page: () => const Cart(),
      transition: Transition.rightToLeft,
      binding: AuthBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
