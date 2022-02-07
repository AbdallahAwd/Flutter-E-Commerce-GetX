import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/modules/home/controllers/home_controller.dart';
import 'package:get_practise/app/modules/home/Models/products_model.dart';

import 'product_details.dart';

// ignore: use_key_in_widget_constructors
class Home extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return GridView.builder(
          itemBuilder: (context, index) => productsBuilder(
            controller.productsList[index],
            index: index,
          ),
          itemCount: controller.productsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 0.68,
          ),
        );
      }
    });
  }
}

Widget productsBuilder(ProductsModel product, {int index = 0}) {
  HomeController homeController = Get.put(HomeController());
  return InkWell(
    onTap: () {
      Get.to(ProductDetails(product, index),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 300));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: 180,
        height: 250,
        child: Card(
          elevation: 12,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Obx(() {
                    return IconButton(
                        onPressed: () {
                          homeController.addToFavorite(product.id);
                        },
                        icon: homeController.isFavorite(product.id)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border_outlined,
                              ));
                  })),
                  const SizedBox(
                    width: 80,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed: () {
                      homeController.addToCart(product);
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: NetworkImage(product.image),
                  fit: BoxFit.contain,
                  height: 150,
                  width: 165,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(child: Text('${product.price}\$')),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 71, 230, 155),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Text(product.rating.rate.toString()),
                          const SizedBox(
                            width: 2,
                          ),
                          const Icon(Icons.star, size: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
