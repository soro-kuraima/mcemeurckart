import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/util/firebase_auth_helper.dart';

class AuthController extends GetxController {
  final auth = Rxn<User>();
  RxBool isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    auth.bindStream(FirebaseAuthHelper.firebaseAuthHelper.onAuthStateChanged);

    ever(
        auth,
        (_) => {
              auth.listen((User? user) {
                if (user == null) {
                  isAuthenticated.value = false;
                } else {
                  isAuthenticated.value = true;
                }
              })
            });

    update();
  }
}
