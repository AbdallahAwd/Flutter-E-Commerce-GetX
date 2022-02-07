import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(controller.appBarTitle[controller.index.value]),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Paths.SEARCH);
                  },
                  icon: const Icon(Icons.search)),
              if (controller.index.value == 0)
                IconButton(
                    onPressed: () {
                      Get.toNamed(Paths.CART);
                    },
                    icon: Badge(
                      badgeContent: Text(controller.cartMap.length.toString()),
                      child: const Icon(
                        Icons.shopping_cart,
                      ),
                    ))
              else
                const SizedBox(
                  height: 0,
                )
            ],
          ),
          body: IndexedStack(
            index: controller.index.value,
            // ignore: invalid_use_of_protected_member
            children: controller.screens.value,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'Category',
                  icon: Icon(Icons.category_outlined),
                  activeIcon: Icon(Icons.category)),
              BottomNavigationBarItem(
                  label: 'Favorite',
                  icon: Icon(Icons.favorite_border_outlined),
                  activeIcon: Icon(Icons.favorite)),
              BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings)),
            ],
            currentIndex: controller.index.value,
            onTap: (index) => controller.index.value = index,
          ),
        ));
  }
}
