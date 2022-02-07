import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/modules/home/controllers/home_controller.dart';
import 'package:get_practise/app/modules/home/views/home.dart';

class CatList extends GetView<HomeController> {
  const CatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Get.arguments),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              itemBuilder: (context, index) =>
                  productsBuilder(controller.categoryDetailsList[index]),
              itemCount: controller.categoryDetailsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 0.68,
              ),
            );
          }
        }));
  }
}
