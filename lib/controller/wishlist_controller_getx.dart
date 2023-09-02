import 'dart:developer';

import 'package:get/get.dart';
import 'package:mcemeurckart/models/products_model.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class WishlistController extends GetxController {
  RxList<int> wishlist = RxList<int>();
  RxList<Product> wishlistItems = RxList<Product>();

  @override
  void onInit() async {
    super.onInit();
    await getWishListItems();
  }

  @override
  void onReady() {
    super.onReady();
    wishlist.bindStream(FireBaseStoreHelper.getWishList());

    ever(wishlist, (_) {
      getWishListItems();
    });
  }

  Future<void> getWishListItems() async {
    log('getWishListItems');
    wishlistItems.clear(); // Clear the list before adding new items
    await Future.forEach(wishlist, (element) async {
      final value = await FireBaseStoreHelper.getProduct(element);
      wishlistItems.add(Product(
        index: value['index'],
        title: value['title'],
        description: value['description'],
        price: value['price'],
        imageUrl: value['imageUrl'],
        stock: value['stock'],
      ));
    });
    log(wishlist.toString());
    log(wishlistItems.toString());
  }

  void addToWishlist(Product product) async {
    log('addToWishlist');
    final index =
        wishlistItems.indexWhere((item) => item.index == product.index);
    if (index == -1) {
      await FireBaseStoreHelper.addToWishlist(product.index);
      update();
    } else {
      Get.snackbar(
        'Product already in wishlist',
        'The selected product is already in your wishlist.',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFromWishlist(Product product) async {
    await FireBaseStoreHelper.removeFromWishList(product.index);
    update();
  }
}
