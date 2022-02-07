import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/modules/home/controllers/home_controller.dart';
import 'package:get_practise/app/routes/app_pages.dart';

// ignore: must_be_immutable
class Categories extends GetView<HomeController> {
  const Categories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.separated(
            itemBuilder: (context, index) => categoryBuilder(
                controller.categoryNameList[index], controller, index),
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                ),
            itemCount: controller.categoryNameList.length);
      }
    });
  }

  Widget categoryBuilder(model, HomeController controller, index) => InkWell(
        onTap: () async {
          // await Future.delayed(const Duration(milliseconds: 600));
          controller.getCategoryIndex(index);

          Get.toNamed(Paths.CategoryDETAILS, arguments: model);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                model.toString(),
                style: const TextStyle(fontSize: 25),
              )),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      );
}
