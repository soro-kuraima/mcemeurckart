import 'package:get/get.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class UserController extends GetxController {
  var user = {}.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(FireBaseStoreHelper.getUser());
    update();
  }

  @override
  void onReady() {
    super.onReady();
    update();
  }

  Future<void> updateUserPicture(String imageUrl) async {
    await FireBaseStoreHelper.updateUser({
      'displayPicture': imageUrl,
    });
    update();
  }
}
