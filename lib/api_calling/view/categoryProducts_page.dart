// ignore_for_file: file_names, must_be_immutable
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';
import 'package:getx_cyra_test/core/constant.dart';
import '../../widgets/appbar.dart';
import '../../widgets/gradient_text.dart';
import '../controller/category_product_controller.dart';

class CategoryProductScreen extends StatefulWidget {
  String catname;
  int catid;
  CategoryProductScreen(
      {super.key, required this.catid, required this.catname});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  final CategoryProductControllor controller =
      Get.put(CategoryProductControllor());

  @override
  Widget build(BuildContext context) {
    log('categoryname  =${widget.catname}');
    log('categoryname  =${widget.catid}');
    return Scaffold(
      backgroundColor: cardColor,
      appBar: GradientAppBar(
        title: 'Sort List of ${widget.catname}',
        toolbarHeight: 90,
        icon: const Icon(
          Icons.arrow_back_ios_new,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      body: Obx(() {
        return MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          itemCount: controller.productList.length,
          itemBuilder: (context, index) {
            final data = controller.productList[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                            minHeight: 100, maxHeight: 250),
                        child: Image.network(
                          Webservice().imageUrlproducts + data.image,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              data.productname,
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffb81736),
                                  Color(0xff281537),
                                  Color(0xffb81736),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 4),
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
            );
          },
        );
      }),
    );
  }
}
