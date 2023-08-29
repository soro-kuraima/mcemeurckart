import 'package:mcemeurckart/data/models/category_model_getx.dart';
import 'package:get/get.dart';

class CategoryControllerGetx extends GetxController {
  CategoryModelGetx categoryModelGetx = CategoryModelGetx(i: 0);

  changeCategory({required int temp}) {
    categoryModelGetx.i = temp;
    update();
  }
}
