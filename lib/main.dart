import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_cyra_test/api_calling/view/cart_page.dart';
import 'package:getx_cyra_test/api_calling/view/categoryProducts_page.dart';
import 'package:getx_cyra_test/api_calling/view/drawer_page.dart';
import 'package:getx_cyra_test/api_calling/view/home_page.dart';
import 'package:getx_cyra_test/api_calling/view/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_calling/view/checkout_page.dart';
import 'api_calling/view/login_page.dart';
import 'api_calling/view/orderdetails_page.dart';
import 'api_calling/view/success_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            final bool isLoggedIn = snapshot.data ?? false;
            return GetMaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.orange,
                fontFamily: 'Montserrat', // Set the custom font family globally
              ),
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              initialRoute: isLoggedIn ? '/homeScreen' : '/loginScreen',
              getPages: [
                GetPage(name: '/homeScreen', page: () => HomeScreen()),
                GetPage(name: '/loginScreen', page: () => const LoginScreen()),
                GetPage(name: '/cartScreen', page: () => CartScreen()),
                GetPage(
                    name: '/succsessScreen',
                    page: () => const SuccsessScreen()),
                GetPage(
                    name: '/orderDetailsScreen',
                    page: () => const OrderDetailsScreen()),
                GetPage(
                    name: '/drawerWidget', page: () => const DrawerWidget()),
                GetPage(
                    name: '/registerScreen',
                    page: () => const RegisterScreen()),
                GetPage(
                    name: '/categoryProductScreen',
                    page: () => CategoryProductScreen(
                          catid: 1,
                          catname: '',
                        )),
                GetPage(
                    name: '/checkoutScreen',
                    page: () => CheckoutScreen(
                          cart: const [],
                        )),
              ],
            );
          }
        });
  }
}
