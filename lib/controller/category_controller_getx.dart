import 'package:get/get.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class CategoriesController extends GetxController {
  RxList<dynamic> categories = [].obs;
  RxList<dynamic> rootCategories = [].obs;
  RxList<dynamic> categoriesWithProducts = [].obs;

  RxList<dynamic> filteredCategories = [].obs;

  @override
  void onReady() {
    super.onReady();
    categories.bindStream(FireBaseStoreHelper.getCategories());
    rootCategories.bindStream(FireBaseStoreHelper.getRootCategories());
    categoriesWithProducts
        .bindStream(FireBaseStoreHelper.getCategoriesWithProducts());

    update();
  }
}
