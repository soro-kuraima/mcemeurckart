import 'dart:developer';

import 'package:get/get.dart';
import 'package:mcemeurckart/models/products_model.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class ProductsController extends GetxController {
  RxList<dynamic> products = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    final productsList = await FireBaseStoreHelper.getProducts();

    if (productsList.isNotEmpty) {
      var productListTemp = [];
      for (final item in productsList) {
        log(item.toString());
        log(item['price'].runtimeType.toString());
        log(item['stock'].runtimeType.toString());
        log(item['index'].runtimeType.toString());

        Product product = Product(
          index: item['index'],
          title: item['title'],
          description: item['description'],
          price: item['price'],
          imageUrl: item['imageUrl'],
          stock: item['stock'],
        );
        productListTemp.add(product);
      }
      products.value = List.from(productListTemp);

      update();
    }
  }
}
