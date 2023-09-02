import 'dart:developer';

import 'package:get/get.dart';
import 'package:mcemeurckart/models/products_model.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class CartItem {
  final Product product;

  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({required int quantity}) {
    return CartItem(product: product, quantity: quantity);
  }
}

class CartController extends GetxController {
  RxList<Map<String, dynamic>> cart = RxList<Map<String, dynamic>>();
  RxList<CartItem> cartItems = RxList<CartItem>();

  @override
  void onInit() async {
    super.onInit();
    await getCartItems();
  }

  @override
  void onReady() {
    super.onReady();
    cart.bindStream(FireBaseStoreHelper.getCart());

    ever(cart, (_) {
      getCartItems();
    });
  }

  Future<void> getCartItems() async {
    log('getCartItems');
    cartItems.clear(); // Clear the list before adding new items
    await Future.forEach(cart, (element) async {
      final value = await FireBaseStoreHelper.getProduct(element['product']!);
      cartItems.add(CartItem(
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

  void addToCart(int index) async {
    final idx = cartItems.indexWhere((item) => item.product.index == index);
    if (idx == -1) {
      await FireBaseStoreHelper.addToCart(index);
      update();
    } else {
      Get.snackbar(
        'Product already in cart',
        'The selected product is already in your cart.',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    log('cart ' + cart.toString());
    log('cart items ' + cartItems.toString());
  }

  void removeFromCart(int index) {
    FireBaseStoreHelper.removeFromCart(index);
  }

  void increaseQuantity(int index) {
    FireBaseStoreHelper.incrementQuantity(index);
  }

  void decreaseQuantity(int index) {
    final idx = cartItems.indexWhere((item) => item.product.index == index);
    final item = cartItems[idx];
    if (item.quantity == 1) {
      removeFromCart(index);
    } else {
      FireBaseStoreHelper.decrementQuantity(index);
      update();
    }
  }

  int getTotal() {
    int total = 0;
    for (final item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
