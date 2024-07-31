import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/model/product_model.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';

class ProductControllor extends GetxController {
  var isLoading = true.obs;
  var mostViewedProductList = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var category = await Webservice.fetchProducts();
      if (category != null) {
        mostViewedProductList.value = category;
      }
    } finally {
      isLoading(false);
    }
  }
}
