// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/controller/category_controller.dart';
import 'package:getx_cyra_test/api_calling/view/categoryProducts_page.dart';
import 'package:getx_cyra_test/api_calling/view/product_details_page.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';
import 'package:getx_cyra_test/core/constant.dart';
import 'package:getx_cyra_test/widgets/appbar.dart';
import 'package:getx_cyra_test/widgets/gradient_button.dart';
import 'package:getx_cyra_test/widgets/gradient_text.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/gradient_border.dart';
import '../controller/category_product_controller.dart';
import '../controller/products_controller.dart';
import 'drawer_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CategoryControllor controller = Get.put(CategoryControllor());
  final ProductControllor productController = Get.put(ProductControllor());
  final CategoryProductControllor controller2 =
      Get.put(CategoryProductControllor());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('Alert'),
              content: const Text('Do you want to Exit'),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GradientButton(
                      width: 80,
                      height: 40,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xffb81736),
                          Color.fromARGB(255, 176, 173, 173)
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        'No',
                        style: TextStyle(color: white),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(color: black),
                        ))
                  ],
                )
              ],
            );
          },
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: white,
          appBar: GradientAppBar(
            title: 'E-Commerce',
            toolbarHeight: 90,
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          drawer: const DrawerWidget(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H(5),
                const GradientText(
                  'Category',
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffb81736),
                      Color(0xff281537),
                      Color(0xffb81736),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: 65,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    color: Colors.grey[200],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.category,
                                              color: Colors.grey[600]),
                                          W(5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox(
                    height: 65,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categoryList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller2.fetchCategoryroductP(
                                controller.categoryList[index].id);
                            final c = controller.categoryList[index];
                            Get.to(CategoryProductScreen(
                              catid: c.id,
                              catname: c.category,
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  color: cardColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(iconsList[index]),
                                        W(5),
                                        GradientText(
                                          gradient:
                                              LinearGradient(colors: [a, c, b]),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          controller
                                              .categoryList[index].category,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                const GradientText(
                  'Most Searched Products',
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffb81736),
                      Color(0xff281537),
                      Color(0xffb81736),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                H(10),
                Obx(() {
                  if (productController.isLoading.value) {
                    return Expanded(
                      child: MasonryGridView.builder(
                        itemCount: 10, // Number of shimmer placeholders
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 100,
                                          maxHeight: 250,
                                        ),
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Expanded(
                    child: MasonryGridView.builder(
                      itemCount: productController.mostViewedProductList.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final data =
                            productController.mostViewedProductList[index];
                        return InkWell(
                          onTap: () {
                            Get.to(ProductDetailsScreen(
                              description: data.description,
                              id: data.id,
                              image: data.image,
                              price: data.price.toString(),
                              name: data.productname,
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: GradientBorderContainer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 100,
                                          maxHeight: 250,
                                        ),
                                        child: Image(
                                          image: NetworkImage(
                                            Webservice().imageUrlproducts +
                                                data.image,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data.productname,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${data.price.toString()} \$',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                })
              ],
            ),
          )),
    );
  }
}
