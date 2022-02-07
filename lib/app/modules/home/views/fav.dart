import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/modules/home/Models/products_model.dart';
import 'package:get_practise/app/modules/home/controllers/home_controller.dart';
import 'package:get_practise/app/modules/home/views/product_details.dart';

class Favorite extends GetView<HomeController> {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.favList.isNotEmpty) {
        return ListView.separated(
            itemBuilder: (context, index) =>
                favBuilder(controller.favList[index]),
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemCount: controller.favList.length);
      } else {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline,
              size: 100,
              color: context.theme.backgroundColor,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text('NO Favorites Here'),
          ],
        ));
      }
    });
  }

  Widget favBuilder(ProductsModel model) => InkWell(
        onTap: () => Get.to(ProductDetails(model, model.id)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 150,
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(model.image),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(12)),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.title),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(model.price.toString()),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.addToFavorite(model.id);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
