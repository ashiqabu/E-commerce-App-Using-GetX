import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';

class RegController extends GetxController {
  Future<Map<String, dynamic>?> reg(
      name, phone, address, username, password) async {
    final result =
        await Webservice.register(name, phone, address, username, password);
    log('result in reg controller + $result');
    return result;
  }
}
