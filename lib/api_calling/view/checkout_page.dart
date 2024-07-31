import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant.dart';
import '../../widgets/appbar.dart';
import '../../widgets/gradient_button.dart';
import '../controller/cart_controller.dart';
import '../controller/checkout_controller.dart';
import '../controller/user_controller.dart';
import 'razorpay_page.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartProduct> cart;
  CheckoutScreen({super.key, required this.cart});

  final CheckoutController checkoutController = Get.put(CheckoutController());
  final UserControllor controller = Get.put(UserControllor());

  @override
  Widget build(BuildContext context) {
    checkoutController.cart = cart;

    return Scaffold(
        appBar: GradientAppBar(
          toolbarHeight: 100,
          title: 'CheckOut page',
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx((() {
                  var user = controller.user.value;
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Name : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(user.name),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'Phone : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(user.phone),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'Address : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  user.address,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }))),
            const SizedBox(height: 10),
            Obx(() => RadioListTile(
                  activeColor: const Color.fromARGB(255, 114, 22, 43),
                  value: 1,
                  groupValue: checkoutController.selectedValue.value,
                  onChanged: (int? value) {
                    if (value != null) {
                      checkoutController.updatePaymentMethod(value);
                    }
                  },
                  title: const Text('Cash on Delivery'),
                  subtitle: const Text('pay cash at home'),
                )),
            Obx(() => RadioListTile(
                  activeColor: const Color.fromARGB(255, 114, 22, 43),
                  value: 2,
                  groupValue: checkoutController.selectedValue.value,
                  onChanged: (int? value) {
                    if (value != null) {
                      checkoutController.updatePaymentMethod(value);
                    }
                  },
                  title: const Text('Pay Online'),
                  subtitle: const Text('pay through online method'),
                )),
          ],
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GradientButton(
            width: MediaQuery.of(context).size.width,
            gradient: LinearGradient(
              colors: [a, b, c],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onPressed: () {
              String dateTime = DateTime.now().toString();
              final CartController cartController = Get.find();

              if (checkoutController.paymentMethod.value == "Online") {
                Get.to(() => RazorPayScreen(
                      address: checkoutController.address.value,
                      amount: cartController.totalPrice.toString(),
                      paymentMethod: checkoutController.paymentMethod.value,
                      name: checkoutController.name.value,
                      date: dateTime,
                      phone: checkoutController.phone.value,
                      cart: checkoutController.cart,
                    ));
              } else {
                checkoutController.placeOrder(
                  cartController.totalPrice.toString(),
                  dateTime,
                );
              }
            },
            child: Text(
              'Check Out',
              style: TextStyle(color: white),
            ),
          ),
        ));
  }
}
