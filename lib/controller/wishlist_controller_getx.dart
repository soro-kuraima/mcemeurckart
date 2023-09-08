import 'dart:developer';

import 'package:get/get.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class WishlistController extends GetxController {
  RxList<int> wishlist = RxList<int>();
  RxList<dynamic> wishlistItems = RxList<dynamic>();

  @override
  void onInit() async {
    super.onInit();
    await getWishListItems();
    update();
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
      wishlistItems.add({
        ...value,
      });
    });
    log(wishlist.toString());
    log(wishlistItems.toString());
    update();
  }

  void addToWishlist(dynamic product) async {
    log('addToWishlist');
    final index =
        wishlistItems.indexWhere((item) => item['index'] == product['index']);
    if (index == -1) {
      await FireBaseStoreHelper.addToWishlist(product['index']);
    } else {
      Get.snackbar(
        'Product already in wishlist',
        'The selected product is already in your wishlist.',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFromWishlist(dynamic product) async {
    await FireBaseStoreHelper.removeFromWishList(product['index']);
  }
}
