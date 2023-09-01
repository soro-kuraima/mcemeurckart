import 'dart:developer';

import 'package:get/get.dart';
import 'package:mcemeurckart/models/category_model_getx.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class CategoryControllerGetx extends GetxController {
  CategoryModelGetx categoryModelGetx = CategoryModelGetx(i: 0);

  changeCategory({required int temp}) {
    categoryModelGetx.i = temp;
    update();
  }
}

class GenericsController extends GetxController {
  RxList<dynamic> generics = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchGenerics();
  }

  void fetchGenerics() async {
    final res = await FireBaseStoreHelper.getGenerics();
    log(res.toString());
    if (res.isNotEmpty) {
      var genericList = [];
      for (final item in res.entries) {
        final genericItem = {
          'id': item.key,
          'title': item.value['title'],
          'subCategories': item.value['subCategories'],
        };
        genericList.add(genericItem);
      }
      log(generics.toString());
      generics.value = List.from(genericList);
      log(generics.toString());
      update();
    }
  }
}
