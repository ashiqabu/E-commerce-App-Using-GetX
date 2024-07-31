import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/controller/order_controller.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';
import 'package:intl/intl.dart';

import '../../widgets/appbar.dart';
import '../../widgets/gradient_text.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailsController controller = Get.put(OrderDetailsController());

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Order List',
        fontsize: 16,
        toolbarHeight: 90,
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () {
          Get.toNamed('/homeScreen');
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.orderDetailsList.isEmpty) {
          return const Center(child: Text('No orders found'));
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.orderDetailsList.length,
          itemBuilder: (context, index) {
            log('total length ${controller.orderDetailsList.length.toString()}');
            final orderDetails = controller.orderDetailsList[index];
            return Card(
              child: ExpansionTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMEd().format(orderDetails.date),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(orderDetails.paymentmethod,
                        style: const TextStyle(fontSize: 10)),
                    GradientText(orderDetails.totalamount.toString(),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xffb81736),
                            Color(0xff281537),
                            Color(0xffb81736),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
                children: [
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image(
                                          image: NetworkImage(
                                              Webservice().imageUrlproducts +
                                                  orderDetails
                                                      .products[index].image)),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(orderDetails
                                        .products[index].productname),
                                    GradientText(
                                        '${orderDetails.products[index].price.toString()} /-',
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
                                  ],
                                ),
                              ],
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  '${orderDetails.products[index].quantity} X',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 5);
                    },
                    itemCount: orderDetails.products.length,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
