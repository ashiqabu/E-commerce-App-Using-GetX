import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';
import 'package:getx_cyra_test/widgets/appbar.dart';
import '../../core/constant.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/gradient_text.dart';
import '../controller/cart_controller.dart';
import 'checkout_page.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          toolbarHeight: 100,
          title: 'Cart page',
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.toNamed('/homeScreen');
          },
          actions: [
            Obx(() {
              return cartController.getItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: const Text('Clear cart!'),
                              content: const Text(
                                  'Do you want to clear all items from cart list'),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                          ),
                                        )),
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
                                        cartController.clearCart();
                                        Get.back();
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: white,
                      ),
                    );
            })
          ]),
      body: Obx(() {
        return cartController.getItems.isEmpty
            ? const Center(
                child: Text(
                'Cart is Empty....',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: cartController.getItems.length,
                itemBuilder: (context, index) {
                  final cartProduct = cartController.getItems[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        leading: Image(
                            image: NetworkImage(Webservice().imageUrlproducts +
                                cartProduct.imageUrls)),
                        title: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          cartProduct.name,
                          style: const TextStyle(fontSize: 12),
                        ),
                        subtitle: GradientText(
                            gradient: LinearGradient(colors: [a, b, c]),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            cartProduct.price.toString()),
                        trailing: Container(
                          height: 35,
                          width: 120,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [a, b, c],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    cartProduct.qty == 1
                                        ? cartController.removeItem(cartProduct)
                                        : cartController.decrement(cartProduct);
                                  },
                                  icon: cartProduct.qty == 1
                                      ? Icon(
                                          Icons.delete,
                                          color: white,
                                        )
                                      : Icon(
                                          Icons.remove,
                                          color: white,
                                        )),
                              CircleAvatar(
                                  radius: 12,
                                  child: Center(
                                      child: Text(cartProduct.qty.toString()))),
                              IconButton(
                                  onPressed: () {
                                    cartController.increment(cartProduct);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: white,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
      }),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return GradientText(
                  gradient: LinearGradient(colors: [a, b, c]),
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.bold),
                  'Total : ${cartController.totalPrice.toString()}/-');
            }),
            InkWell(
              borderRadius: BorderRadius.circular(5),
              overlayColor: MaterialStateProperty.all(Colors.black),
              splashColor: (Colors.black),
              onTap: () {
                if (cartController.getItems.isEmpty) {
                  Get.snackbar('Error', 'Cart is Empty!....',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 1));
                } else {
                 
                  Get.to(() => CheckoutScreen(cart: cartController.getItems));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [a, b, c],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                width: MediaQuery.of(context).size.width / 2.2,
                height: 40,
                child: Center(
                    child: Text(
                  'Order Now',
                  style: TextStyle(fontWeight: FontWeight.bold, color: white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
