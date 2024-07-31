import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/controller/login_controller.dart';
import 'package:getx_cyra_test/core/constant.dart';
import '../../widgets/textformfieilds.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LogControllor controller = Get.put(LogControllor());
  bool _isPasswordVisible = true;
  TextEditingController userCntrl = TextEditingController();
  TextEditingController passwordCntrl = TextEditingController();
  bool isLoading = false;

  void checkFields() {
    isLoading = true;
    List<String> missingFields = [];

    if (userCntrl.text.isEmpty) {
      missingFields.add('Email');
    }
    if (passwordCntrl.text.isEmpty) {
      missingFields.add('Password');
    }

    if (missingFields.isEmpty) {
      final Future<Map<String, dynamic>?> successfulMessage =
          controller.logg(userCntrl.text, passwordCntrl.text);
      successfulMessage.then((value) async {
        isLoading = true;
        if (value != null && value['status'] == true) {
          
          Get.snackbar('Successfull', 'Login successfully completed');
          Get.offNamed('/homeScreen');
          _resetFields();
        } else {
          Get.snackbar(
            'Login Failed',
            'login failed fields not match',
          );
        }
      });
    } else {
      Get.snackbar(
          'Please fill the following fields', missingFields.join(', '));
    }
  }

  void _resetFields() {
    userCntrl.clear();
    passwordCntrl.clear();
    setState(() {
      _isPasswordVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffb81736), Color(0xff281537)])),
            child: const Padding(
              padding: EdgeInsets.only(top: 60, left: 20),
              child: Text(
                'Hello User..\nSign in Now',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180, right: 10, left: 10),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: double.infinity,
                decoration: const BoxDecoration(
                    // color: Colors.white,
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 222, 214, 214)
                    ]),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    H(30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        suffixIcon: const Icon(Icons.person),
                        hintText: 'Username',
                        controller: userCntrl,
                        borderColor: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        obscureText: _isPasswordVisible,
                        hintText: 'Password',
                        controller: passwordCntrl,
                        borderColor: Colors.red,
                      ),
                    ),
                    H(10),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text('Forgot Password?'),
                      ),
                    ),
                    H(60),
                    isLoading == true
                        ? const Center(child: CircularProgressIndicator())
                        : InkWell(
                            onTap: checkFields,
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffb81736),
                                    Color(0xff281537)
                                  ])),
                              child: const Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                    H(50),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Don't have account?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 94, 91, 91)),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed('/registerScreen');
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
