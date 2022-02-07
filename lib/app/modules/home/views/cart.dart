import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/modules/home/Models/products_model.dart';
import 'package:get_practise/app/modules/home/controllers/home_controller.dart';

class Cart extends GetView<HomeController> {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cart ithms'),
          centerTitle: true,
        ),
        body: controller.cartMap.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return cartItem(
                      controller.cartMap.keys.toList()[index], index);
                },
                itemCount: controller.cartMap.length)
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart, size: 100),
                    const SizedBox(
                      height: 25,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Your Cart is ',
                          style: context.theme.textTheme.caption!
                              .copyWith(fontSize: 25)),
                      TextSpan(
                          text: 'Empty',
                          style: TextStyle(
                              color: context.theme.backgroundColor,
                              fontSize: 30))
                    ])),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Go to Home'))
                  ],
                ),
              ),
        persistentFooterButtons: [
          controller.cartMap.isEmpty
              ? const SizedBox()
              : Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${controller.total}\$')
                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(290, 50),
                            primary: Get.isDarkMode
                                ? const Color.fromARGB(255, 60, 1, 155)
                                : context.theme.backgroundColor),
                        label: const Text('Check out'),
                        icon: const Icon(Icons.payment_outlined))
                  ],
                )
        ],
      );
    });
  }

  Widget cartItem(ProductsModel model, index) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 140,
          child: Card(
            elevation: 12,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15, bottom: 8, right: 8, top: 8),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(model.image),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                            '${controller.subTotal[index].toStringAsFixed(2)}\$'),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            controller.removeFromCart(model);
                          },
                          icon: const Icon(Icons.remove_circle)),
                      Text('${controller.cartMap.values.toList()[index]}'),
                      IconButton(
                          onPressed: () {
                            controller.addToCart(model);
                          },
                          icon: const Icon(Icons.add_circle)),
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                          onTap: () {
                            controller.removeOneItemFromCart(model);
                          },
                          child: const Icon(Icons.delete)))
                ],
              ),
            ),
          ),
        ),
      );
}
