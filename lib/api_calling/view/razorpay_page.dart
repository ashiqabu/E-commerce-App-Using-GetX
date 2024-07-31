import 'package:flutter/material.dart';
import '../controller/cart_controller.dart';

class RazorPayScreen extends StatelessWidget {
  final String address;
  final String amount;
  final String paymentMethod;
  final String name;
  final String date;
  final String phone;
  final List<CartProduct> cart;

  const RazorPayScreen({super.key, 
    required this.address,
    required this.amount,
    required this.paymentMethod,
    required this.name,
    required this.date,
    required this.phone,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    // Your RazorPay implementation goes here
    return Scaffold(
      appBar: AppBar(
        title: Text('RazorPay Payment'),
      ),
      body: Center(
        child: Text('Implement RazorPay Payment'),
      ),
    );
  }
}
