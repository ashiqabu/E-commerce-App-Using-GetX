import 'package:get/get.dart';
import '../model/user_model.dart';
import '../webservice.dart';

class UserControllor extends GetxController {
  var isLoading = true.obs;
  var user = UserModel(name: '', phone: '', address: '', username: '').obs;

  void fetchUser(String username) async {
    try {
      isLoading(true);
      var fetchedUser = await Webservice.fetchUser(username);
      user.value = fetchedUser;
        } finally {
      isLoading(false);
    }
  }
}
