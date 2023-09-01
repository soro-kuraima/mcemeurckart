import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mcemeurckart/models/products_model.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  final Product product;
  @HiveField(1)
  final int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({required int quantity}) {
    return CartItem(product: product, quantity: quantity);
  }
}

class CartController extends GetxController {
  late Box<CartItem> _cartBox;
  RxList<CartItem> cartItems = RxList<CartItem>();
  RxInt sumTotal = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await _openBox();
    cartItems.assignAll(_cartBox.values.toList());
    updateSumTotal();
  }

  @override
  void onClose() {
    _cartBox.close();
    super.onClose();
  }

  Future<void> _openBox() async {
    _cartBox = await Hive.openBox<CartItem>('cart');
  }

  void addToCart(CartItem cartItem) {
    final index = cartItems
        .indexWhere((item) => item.product.index == cartItem.product.index);
    if (index == -1) {
      cartItems.add(cartItem);
      _cartBox.add(cartItem);
    } else {
      Get.snackbar(
        'Product already in cart',
        'The selected product is already in your cart.',
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    updateSumTotal();
    update();
  }

  void removeFromCart(int index) {
    final item = cartItems[index];
    cartItems.removeAt(index);
    _cartBox.delete(item.key);
    updateSumTotal();
    update();
  }

  void increaseQuantity(CartItem cartItem) {
    final index = cartItems
        .indexWhere((item) => item.product.index == cartItem.product.index);
    final item = cartItems[index];
    cartItems[index] = item.copyWith(quantity: item.quantity + 1);
    _cartBox.put(item.key, cartItems[index]);
    updateSumTotal();
    update();
  }

  void decreaseQuantity(CartItem cartItem) {
    final index = cartItems
        .indexWhere((item) => item.product.index == cartItem.product.index);
    final item = cartItems[index];
    if (item.quantity == 1) {
      cartItems.removeAt(index);
      _cartBox.delete(item.key);
    } else {
      cartItems[index] = item.copyWith(quantity: item.quantity - 1);
      _cartBox.put(item.key, cartItems[index]);
    }
    updateSumTotal();
    update();
  }

  void updateSumTotal() {
    sumTotal.value = cartItems.fold<int>(
        0, (sum, item) => sum + item.product.price * item.quantity);
  }
}
