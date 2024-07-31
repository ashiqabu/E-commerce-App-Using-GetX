import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constant.dart';
import '../../widgets/gradient_button.dart';

class SuccsessScreen extends StatelessWidget {
  const SuccsessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(width: 200, 'animation/WdXBKIAKKK.json'),
            H(10),
            const Text(
              'Order Taken',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            H(5),
            const Text(
                textAlign: TextAlign.center,
                'Your order has been placed and will be delivered shortly...'),
            H(20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GradientButton(
                width: MediaQuery.of(context).size.width / 1.4,
                gradient: LinearGradient(
                  colors: [a, b, c],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onPressed: () {
                  Get.offAndToNamed('/orderDetailsScreen');
                },
                child: Text(
                  'Track order',
                  style: TextStyle(color: white),
                ),
              ),
            ),
            H(15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GradientButton(
                width: MediaQuery.of(context).size.width / 1.4,
                gradient: LinearGradient(
                  colors: [a, b, c],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onPressed: () {
                  Get.offAndToNamed('/homeScreen');
                },
                child: Text(
                  'Continue shopping',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
