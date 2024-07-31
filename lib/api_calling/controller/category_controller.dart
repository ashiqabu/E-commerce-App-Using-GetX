import 'package:get/get.dart';
import 'package:getx_cyra_test/api_calling/model/category_model.dart';
import 'package:getx_cyra_test/api_calling/webservice.dart';

class CategoryControllor extends GetxController {
  var isLoading = true.obs;
  var categoryList = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategory();
    super.onInit();
  }

  void fetchCategory() async {
    try {
      isLoading(true);
      var category = await Webservice.fetchCategory();
      if (category != null) {
        categoryList.value = category;
      }
    } finally {
      isLoading(false);
    }
  }
}
