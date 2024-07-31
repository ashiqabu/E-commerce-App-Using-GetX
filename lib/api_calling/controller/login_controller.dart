import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';

class LogControllor extends GetxController {
  Future<Map<String, dynamic>?> logg(username, password) async {
    
    final result = await Webservice.login(username, password);
    log('result in login controller + $result');
    return result;
  }
}



