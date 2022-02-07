import 'package:flutter/material.dart';
import 'package:get_practise/app/modules/home/controllers/home_controller.dart';
import 'package:get_practise/app/modules/home/views/home.dart';
import 'package:get/get.dart';

class Search extends GetView<HomeController> {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: controller.searchController,
            decoration: InputDecoration(
                filled: true,
                fillColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
                hintText: 'Search For what you want?',
                prefixIcon: const Icon(Icons.search),
                suffix: InkWell(
                    onTap: () {
                      controller.clearSearch();
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.blue,
                    ))),
            onChanged: (value) {
              controller.addToSearchList(value);
            },
          ),
        ),
        body: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.searchList.isNotEmpty) {
              return GridView.builder(
                itemBuilder: (context, index) =>
                    productsBuilder(controller.searchList[index], index: index),
                itemCount: controller.searchList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 0.68,
                ),
              );
            } else {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      color: context.theme.backgroundColor,
                      size: 80,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'No result found',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
