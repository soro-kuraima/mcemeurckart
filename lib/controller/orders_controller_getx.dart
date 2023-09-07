import 'dart:developer';

import 'package:get/get.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class OrdersController extends GetxController {
  RxList<dynamic> orders = [].obs;
  var orderItem = {}.obs;

  @override
  void onReady() {
    super.onReady();
    orders.bindStream(FireBaseStoreHelper.getOrders());
    update();
  }

  void placeOrder(int orderValue) async {
    await FireBaseStoreHelper.placeOrder(orderValue);
    update();
  }

  Future<void> setOrderItem(int index) async {
    orderItem.clear();
    final productList = [];
    final productIndices = orders[index]['products'].entries;
    await Future.forEach(productIndices,
        (MapEntry<String, dynamic> element) async {
      final product =
          await FireBaseStoreHelper.getProduct(element.value['product']);
      productList
          .add({'product': product, 'quantity': element.value['quantity']});
    });
    orderItem.value = {
      ...orders[index],
      'products': productList,
    };
    log(orderItem.toString());
    update();
  }
}
