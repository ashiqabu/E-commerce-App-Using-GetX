import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_controller.dart';

class CheckoutController extends GetxController {
  var selectedValue = 1.obs;
  var username = ''.obs;
  var name = ''.obs;
  var phone = ''.obs;
  var address = ''.obs;
  var paymentMethod = 'Cash on delivery'.obs;

  List<CartProduct> cart = [];

  final CartController cartController = Get.find<CartController>();

  @override
  void onInit() {
    super.onInit();
    loadUsername();
  }

  void loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
    //fetchUserDetails();
  }

  void updatePaymentMethod(int value) {
    selectedValue.value = value;
    paymentMethod.value = value == 1 ? 'Cash on delivery' : 'Online';
  }

  void placeOrder(String amount, String date) async {
    String jsonData = jsonEncode(cart);

    final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/ecom.order.php"),
        body: {
          'username': username.value,
          'amount': amount,
          'paymentmethod': paymentMethod.value,
          'date': date,
          'cart': jsonData,
          'name': name.value,
          'address': address.value,
          'phone': phone.value
        });

    if (response.statusCode == 200) {
      if (response.body.contains('Success')) {
        cartController.clearCart();
        Get.offAllNamed('/succsessScreen');
      }
    }
  }
}
