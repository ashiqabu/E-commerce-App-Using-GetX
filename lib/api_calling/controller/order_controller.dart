import 'dart:developer';
import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';
import 'package:getx_cyra_test/api_calling/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsController extends GetxController {
  var username = ''.obs;
  var orderDetailsList = <OrderModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUsername();
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
    log('username : ${username.value}');
    fetchOrderDetails();
  }

  void fetchOrderDetails() async {
    try {
      isLoading(true);
      var orders = await Webservice.fetchOrderDetails(username.value);
      if (orders != null) {
        orderDetailsList.assignAll(orders);
      }
    } finally {
      isLoading(false);
    }
  }
}
