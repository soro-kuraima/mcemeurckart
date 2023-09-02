import 'dart:developer';

import 'package:get/get.dart';
import 'package:mcemeurckart/controller/cart_controller_getx.dart';
import 'package:mcemeurckart/models/products_model.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class OrdersController extends GetxController {
  RxList<dynamic> orders = [].obs;

  @override
  void onReady() {
    super.onReady();
    orders.bindStream(FireBaseStoreHelper.getOrders());

    ever(orders, (_) {
      getOrders();
    });
  }

  Future<void> getOrders() async {
    log('getOrders');
    orders.clear(); // Clear the list before adding new items
    await Future.forEach(orders, (element) async {
      final value = await FireBaseStoreHelper.getProduct(element['product']!);
      orders.add(CartItem(
        product: Product(
          index: value['index'],
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          stock: value['stock'],
        ),
        quantity: element['quantity']!,
      ));
      update();
    });
  }

  void placeOrder(int orderValue) async {
    await FireBaseStoreHelper.placeOrder(orderValue);
    update();
  }
}
