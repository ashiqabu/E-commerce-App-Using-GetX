import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/controller/cart_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constant.dart';
import '../../widgets/gradient_button.dart';
import '../controller/user_controller.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final UserControllor controller = Get.put(UserControllor());
  final CartController cartcontroller = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  String? username;

  _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    if (username != null) {
      controller.fetchUser(username!);
    }
    log('Username ===${username.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return const DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (controller.user.value.username.isNotEmpty) {
                var user = controller.user.value;
                return DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffb81736),
                        Color(0xff281537),
                        Color.fromARGB(255, 176, 173, 173)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        user.phone,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        user.address,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                      'No user data available',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            }),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Badge(
                  isLabelVisible:
                      cartcontroller.getItems.isEmpty ? false : true,
                  label: Text(cartcontroller.getItems.length.toString()),
                  child: const Icon(Icons.shopping_cart)),
              title: const Text('Cart Page'),
              onTap: () {
                Get.toNamed('/cartScreen');
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Order Details'),
              onTap: () {
                Get.toNamed('/orderDetailsScreen');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text('Log Out'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: white,
                      title: const Text('Logout!..'),
                      content: const Text('Do you want to logout...'),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("isLoggedIn", false);

                              Get.offNamed('/loginScreen');
                            },
                            child: Text(
                              'yes',
                              style: TextStyle(color: black),
                            )),
                        GradientButton(
                          width: 70,
                          height: 35,
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
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
