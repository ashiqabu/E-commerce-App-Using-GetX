import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_cyra_test/core/constant.dart';
import 'package:getx_cyra_test/widgets/snackbar.dart';
import '../../widgets/textformfieilds.dart';
import '../controller/registeration_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegController controller = Get.put(RegController());
  bool isLoading = false;
  void checkFields() {
    List<String> missingFields = [];

    if (nameCntrl.text.isEmpty) {
      missingFields.add('Name');
    }

    if (phoneCntrl.text.isEmpty) {
      missingFields.add('Phone Number');
    }
    if (addressCntrl.text.isEmpty) {
      missingFields.add('Address');
    }
    if (userCntrl.text.isEmpty) {
      missingFields.add('Email');
    }
    if (passwordCntrl.text.isEmpty) {
      missingFields.add('Password');
    }

    if (missingFields.isEmpty) {
      if (phoneCntrl.text.length != 10) {
        showCustomSnackBar(
            context, 'Phone number must have 10 digits', Colors.blue);
      } else {
        final Future<Map<String, dynamic>?> succsessFullMessage =
            controller.reg(nameCntrl.text, passwordCntrl.text,
                addressCntrl.text, userCntrl.text, passwordCntrl.text);
        succsessFullMessage.then((value) async {
          if (value!['msg'] == "success") {
            showCustomSnackBar(
                context, 'Registration successfully completed', Colors.green);
             Get.toNamed('/loginScreen');
            _resetFields();
          } else {
            showCustomSnackBar(context, 'Registration failed', Colors.red);
          }
        });
      }
    } else {
      showCustomSnackBar(
          context,
          'Please fill the following fields: ${missingFields.join(', ')}',
          Colors.blue);
    }
  }

  void _resetFields() {
    nameCntrl.clear();
    phoneCntrl.clear();
    addressCntrl.clear();
    userCntrl.clear();
    passwordCntrl.clear();
    setState(() {
      _isPasswordVisible = false;
    });
  }

  bool _isPasswordVisible = true;
  TextEditingController userCntrl = TextEditingController();
  TextEditingController passwordCntrl = TextEditingController();
  TextEditingController nameCntrl = TextEditingController();
  TextEditingController phoneCntrl = TextEditingController();
  TextEditingController addressCntrl = TextEditingController();

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
                'Hello User..\nSign Up Now!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 170, right: 10, left: 10),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                    //color: Colors.white,
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 171, 159, 159)
                    ]),
                    borderRadius: BorderRadius.only(
                      //topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      // bottomRight: Radius.circular(40),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        suffixIcon: const Icon(Icons.person),
                        hintText: 'Name',
                        controller: nameCntrl,
                        borderColor: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        suffixIcon: const Icon(Icons.mobile_screen_share),
                        hintText: 'Phone Number',
                        controller: phoneCntrl,
                        borderColor: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        suffixIcon: const Icon(Icons.details),
                        hintText: 'Address',
                        controller: addressCntrl,
                        borderColor: Colors.red,
                      ),
                    ),
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
                    H(30),
                    InkWell(
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
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    H(20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Already have an have account?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 94, 91, 91)),
                            ),
                            InkWell(
                              onTap: () {
                                  Get.toNamed('/loginScreen');
                              },
                              child: const Text(
                                "Sign In",
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
