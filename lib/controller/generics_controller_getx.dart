import 'package:get/get.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class GenericsController extends GetxController {
  RxList<dynamic> generics = [].obs;

  @override
  void onReady() {
    super.onReady();
    generics.bindStream(FireBaseStoreHelper.getGenerics());
    update();
  }
}
