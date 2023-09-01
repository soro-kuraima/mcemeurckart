import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mcemeurckart/models/products_model.dart';

class WishlistController extends GetxController {
  late Box<Product> _wishlistBox;
  RxList<Product> wishlistItems = RxList<Product>();

  @override
  void onInit() async {
    super.onInit();
    _openBox();
    wishlistItems.assignAll(_wishlistBox.values.toList());
  }

  @override
  void onClose() {
    _wishlistBox.close();
    super.onClose();
  }

  Future<void> _openBox() async {
    _wishlistBox = await Hive.openBox<Product>('wishlist');
  }

  void addToWishlist(Product product) {
    final index =
        wishlistItems.indexWhere((item) => item.index == product.index);
    if (index == -1) {
      wishlistItems.add(product);
      _wishlistBox.add(product);
    } else {
      Get.snackbar(
        'Product already in wishlist',
        'The selected product is already in your wishlist.',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFromWishlist(Product product) {
    wishlistItems.removeWhere((item) => item.index == product.index);
    _wishlistBox.delete(product.index);
  }
}
