import 'dart:developer';
import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';
import '../model/product_model.dart';

class CategoryProductControllor extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;

  void fetchCategoryroductP(int catId) async {
    log('category id = ${catId.toString()}');
    try {
      isLoading(true);
      var category = await Webservice.fetchCategoryProduct(catId);
      if (category != null) {
        productList.value = category;
      }
      log('pro list length =${productList.length}');
    } finally {
      isLoading(false);
    }
  }
}
