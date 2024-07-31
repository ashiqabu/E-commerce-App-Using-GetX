import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';
import 'package:getx_cyra_test/widgets/gradient_text.dart';

import '../../core/constant.dart';
import '../controller/cart_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String name, price, image, description;
  final int id;

  const ProductDetailsScreen({
    super.key,
    required this.description,
    required this.id,
    required this.image,
    required this.price,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: fillColor,
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      fit: BoxFit.fill,
                      image:
                          NetworkImage(Webservice().imageUrlproducts + image),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 50),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GradientText(name,
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
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GradientText(price,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffb81736),
                              Color(0xff281537),
                              Color(0xffb81736),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          style: const TextStyle()),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GradientText(description,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffb81736),
                              Color(0xff281537),
                              Color(0xffb81736),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          style: const TextStyle()),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomSheet: InkWell(
          onTap: () {
            bool isAlreadyInCart = cartController.itemExists(id);

            if (isAlreadyInCart) {
              Get.snackbar('Already in cart', 'Item alredy exist in cart',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 1));
            } else {
              cartController.addItem(id, name, double.parse(price), 1, image);
              Get.snackbar('Successfully added', 'Added to cart list',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 1));
              log(cartController.count.toString());
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffb81736),
                    Color(0xff281537),
                    Color.fromARGB(255, 176, 173, 173)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: fontSize, color: white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
