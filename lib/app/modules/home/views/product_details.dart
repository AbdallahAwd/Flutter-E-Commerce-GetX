import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_practise/app/modules/home/Models/products_model.dart';
import 'package:get_practise/app/modules/home/controllers/home_controller.dart';
import 'package:get_practise/app/routes/app_pages.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends GetView<HomeController> {
  final ProductsModel product;
  final int itemIndex;
  // ignore: use_key_in_widget_constructors
  const ProductDetails(this.product, this.itemIndex);
  @override
  Widget build(BuildContext context) {
    List<String> clothSize = ['S', 'M', 'L', 'XL', 'XXL'];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (context, index, rIndex) {
                          return Container(
                              decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: NetworkImage(product.image),
                                fit: BoxFit.contain),
                          ));
                        },
                        options: CarouselOptions(
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1300),
                          autoPlay: true,
                          height: 500,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            controller.smoothIndecator(index);
                          },
                          autoPlayCurve: Curves.easeInOutBack,
                          enableInfiniteScroll: true,
                        )),
                    Obx(() {
                      return Positioned(
                          bottom: 30,
                          left: 180,
                          child: AnimatedSmoothIndicator(
                            activeIndex: controller.smoothIndecatorIndex.value,
                            count: 3,
                            effect: const ExpandingDotsEffect(
                              dotHeight: 10,
                              dotWidth: 12,
                            ),
                          ));
                    }),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? const Color.fromARGB(255, 60, 1, 155)
                                    : context.theme.backgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Paths.CART);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? const Color.fromARGB(255, 60, 1, 155)
                                    : context.theme.backgroundColor,
                                shape: BoxShape.circle,
                              ),
                              child: Badge(
                                badgeContent:
                                    Text(controller.cartMap.length.toString()),
                                child: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Text(product.rating.rate.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    RatingBar.builder(
                      initialRating: product.rating.rate,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ReadMoreText(
                  product.description,
                  trimCollapsedText: 'Show More',
                  trimExpandedText: 'Show Less',
                  trimLength: 150,
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  textScaleFactor: 1.3,
                  moreStyle: const TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.bold),
                  lessStyle: const TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (itemIndex <= 3)
                  GetBuilder<HomeController>(builder: (controller) {
                    return SizedBox(
                      height: 35,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: clothSize.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => controller.clothSize(index),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: controller.clothSizeIndex == index
                                      ? Colors.grey
                                      : Get.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)),
                              width: 40,
                              child: Center(child: Text(clothSize[index])),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                      ),
                    );
                  }),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('${product.price.toString()}\$')
                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          controller.addToCart(product);
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(290, 50),
                            primary: Get.isDarkMode
                                ? const Color.fromARGB(255, 60, 1, 155)
                                : context.theme.backgroundColor),
                        label: const Text('Add to Cart'),
                        icon: const Icon(Icons.shopping_cart))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
