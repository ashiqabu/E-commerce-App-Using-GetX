// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables
import 'dart:convert';

import 'package:getx_cyra_test/api_calling/model/category_model.dart';
import 'package:getx_cyra_test/api_calling/model/product_model.dart';
import 'package:getx_cyra_test/api_calling/model/response_model.dart';
import 'package:getx_cyra_test/api_calling/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'model/order_model.dart';

class Webservice {
  final imageUrlproducts = 'http://bootcamp.cyralearnings.com/products/';
  static Future<Map<String, dynamic>?> register(
      String name, phone, address, username, password) async {
    log('current username = ' + username);

    final Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password
    };

    try {
      final response = await http.post(
          Uri.parse("http://bootcamp.cyralearnings.com/ecom.registration.php"),
          body: data);
      if (response.statusCode == 200) {
        log(response.body);
        log(response.statusCode.toString());
        var jsonString = response.body;
        var result;
        ResponseModel ws = responseModelFromjson(jsonString);
        result = {'status': true, 'msg': ws.msg, 'Webservices': ws};
        return result;
      } else {
        return null;
      }
    } catch (e) {
      throw {Exception(e.toString())};
    }
  }

  static Future<Map<String, dynamic>?> login(
      String username, String password) async {
    log('current username = $username');
    final Map<String, dynamic> data = {
      'username': username,
      'password': password,
    };
    log("login data ==== $data");
    try {
      final response = await http.post(
          Uri.parse("http://bootcamp.cyralearnings.com/ecom.login.php"),
          body: data);
      if (response.statusCode == 200) {
        if (response.body.contains('success')) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString('username', username);
          log(username);
          log(password);
          var jsonString = response.body;
          var result;
          ResponseModel ws = responseModelFromjson(jsonString);
          result = {'status': true, 'msg': ws.msg, 'Webservices': ws};
          return result;
        } else {
          return null;
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  static Future<List<CategoryModel>?> fetchCategory() async {
    var response = await http.get(
        Uri.parse('http://bootcamp.cyralearnings.com/ecom.getcategories.php'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      log('response = ' + response.body);
      return categoryFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<ProductModel>?> fetchCategoryProduct(int catid) async {
    var response = await http.post(
        Uri.parse(
            'http://bootcamp.cyralearnings.com/ecom.get_category_products.php'),
        body: {'catid': catid.toString()});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      log('Category products' + jsonString);
      return productFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<ProductModel>?> fetchProducts() async {
    var response = await http.get(Uri.parse(
        'http://bootcamp.cyralearnings.com/ecom.view_offerproducts.php'));
    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;
        //log('most viewed products = ' + jsonString);
        return productFromJson(jsonString);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<UserModel> fetchUser(String username) async {
    final response = await http.post(
      Uri.parse('http://bootcamp.cyralearnings.com/ecom.get_user.php'),
      body: {'username': username},
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to connect API');
    }
  }

  static Future<List<OrderModel>?> fetchOrderDetails(String username) async {
    log('username : $username');
    try {
      final response = await http.post(
        Uri.parse(
            'http://bootcamp.cyralearnings.com/ecom.get_orderdetails.php'),
        body: {'username': username},
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
