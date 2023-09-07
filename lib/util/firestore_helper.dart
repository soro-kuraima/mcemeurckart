import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcemeurckart/util/firebase_auth_helper.dart';

class FireBaseStoreHelper {
  FireBaseStoreHelper._();

  static final user =
      FirebaseAuthHelper.firebaseAuthHelper.firebaseAuth.currentUser;

  static final FireBaseStoreHelper fireBaseStoreHelper =
      FireBaseStoreHelper._();
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static final genericsRef = db.collection('generics');
  static final categoriesRef = db.collection('categories');
  static final productsRef = db.collection('products');

  //static final generics = categoriesRef.doc('generics');
  //static final rootCategories = categoriesRef.doc('root-categories');
  //static final productCategories = categoriesRef.doc('product-categories');

  static Stream<List<Map<String, dynamic>>> getGenerics() {
    try {
      return genericsRef.snapshots().map((event) {
        return event.docs.map((e) {
          return {
            'id': e.id,
            'title': e.data()['title'],
            'categories': e.data()['categories'],
          };
        }).toList();
      });
    } catch (e) {
      print(e);
    }

    return const Stream.empty();
  }

  static Stream<List<Map<String, dynamic>>> getCategories() {
    try {
      return categoriesRef.snapshots().map((event) {
        return event.docs.map((e) {
          return {
            'id': e.id,
            ...e.data(),
          };
        }).toList();
      });
    } catch (e) {
      print(e);
    }
    return const Stream.empty();
  }

  static Stream<List<Map<String, dynamic>>> getRootCategories() {
    final rootCategoriesRef = categoriesRef.where('isRoot', isEqualTo: true);
    try {
      return rootCategoriesRef.snapshots().map((event) {
        return event.docs.map((e) {
          return {
            'id': e.id,
            ...e.data(),
          };
        }).toList();
      });
    } catch (e) {
      print(e);
    }
    return const Stream.empty();
  }

  static Stream<List<Map<String, dynamic>>> getCategoriesWithProducts() {
    final rootCategoriesRef =
        categoriesRef.where('hasProducts', isEqualTo: true);
    try {
      return rootCategoriesRef.snapshots().map((event) {
        return event.docs.map((e) {
          return {'id': e.id, ...e.data()};
        }).toList();
      });
    } catch (e) {
      print(e);
    }
    return const Stream.empty();
  }

  static Stream<List<Map<String, dynamic>>> getProducts() {
    try {
      return productsRef.snapshots().map((event) {
        return event.docs.map((e) {
          return {
            'id': e.id,
            'index': e.data()['index'],
            'title': e.data()['title'],
            'price': e.data()['price'],
            'imageUrl': e.data()['imageUrl'],
            'description': e.data()['description'],
            'category': e.data()['category'],
            'stock': e.data()['stock'],
            'generic': e.data()['generic']
          };
        }).toList();
      });
    } catch (e) {
      print(e);
    }

    return const Stream.empty();
  }

  static Future<Map<String, dynamic>> getProduct(int index) async {
    Map<String, dynamic> res = {};
    final product = productsRef.doc(index.toString());
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await product.get();
      res = documentSnapshot.data()!;
    } catch (e) {
      print(e);
    }
    return res;
  }

  /* ============= to add and remove items from wishlist ============== */

  static final wishlistRef = db.collection('wishlist');
  static final wishlist = wishlistRef.doc(user!.email);
  static Future<void> createWishList() async {
    try {
      await wishlist.set({'products': []}, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  static Stream<List<int>> getWishList() {
    return wishlist.snapshots().map((event) {
      final data = event.data();
      if (data != null) {
        return List.from(data['products']);
      }
      return [];
    });
  }

  static Future<void> addToWishlist(int index) async {
    try {
      await wishlist.update({
        'products': FieldValue.arrayUnion([index])
      });
    } catch (e) {
      print(e);
    } finally {
      print('Product added to wishlist');
    }
  }

  static Future<void> removeFromWishList(int index) async {
    try {
      await wishlist.update({
        'products': FieldValue.arrayRemove([index])
      });
    } catch (e) {
      print(e);
    } finally {
      print('Product removed from wishlist');
    }
  }

  /* ================= to add, remove and update items in cart ================ */

  static final cartRef = db.collection('cart');
  static final cart = cartRef.doc(user!.email);

  static Future<void> createCart() async {
    try {
      cart.set({}, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  static Stream<List<Map<String, dynamic>>> getCart() {
    return cart.snapshots().map((event) {
      final data = event.data();
      if (data != null) {
        log(data.entries.toString());
        final cartItems = data.entries.map((e) {
          return {
            'product': e.value['product'],
            'quantity': e.value['quantity'],
          };
        }).toList();

        log(cartItems.toString());
        return List.from(cartItems);
      }
      return [];
    });
  }

  static Future<void> addToCart(int index) async {
    try {
      await cart.update({
        '$index': {
          'product': index,
          'quantity': 1,
        }
      });
    } catch (e) {
      print(e);
    } finally {
      print('Product added to cart');
    }
  }

  static Future<void> incrementQuantity(int index) async {
    try {
      await cart.update({'$index.quantity': FieldValue.increment(1)});
    } catch (e) {
      print(e);
    } finally {
      print('Product quantity incremented');
    }
  }

  static Future<void> decrementQuantity(int index) async {
    final cart = cartRef.doc(user!.email);
    try {
      await cart.update({'$index.quantity': FieldValue.increment(-1)});
    } catch (e) {
      print(e);
    } finally {
      print('Product quantity decremented');
    }
  }

  static Future<void> removeFromCart(int index) async {
    try {
      await cart.update({'$index': FieldValue.delete()});
    } catch (e) {
      print(e);
    } finally {
      print('Product deleted from cart');
    }
  }

  /* ================= to get orders and place orders ============== */

  static final ordersRef = db.collection('orders');

  static Future<void> placeOrder(int orderValue) async {
    try {
      final snapshot = await cart.get();
      if (snapshot.exists) {
        final entries = snapshot.data()?.entries;
        final keys = snapshot.data()?.keys;
        int firstProductIndex = int.parse(keys?.elementAt(0) ?? "0");
        final product = await getProduct(firstProductIndex);
        log(product.toString());
        log("keys of cart $keys");
        log("entries of cart$entries");
        await ordersRef.add({
          'user': user!.email,
          'products': snapshot.data(),
          'orderValue': orderValue,
          'orderStatus': 'pending',
          'orderDate': DateTime.now(),
          'imageUrl': product['imageUrl'],
        });

        await cart.delete();
        await createCart();
      }
    } catch (e) {
      print(e);
    } finally {
      print('Order placed');
    }
  }

  static final ordersQuery = ordersRef.where('user', isEqualTo: user!.email);
  static Stream<List<Map<String, dynamic>>> getOrders() {
    return ordersQuery.snapshots().map((event) {
      final data = event.docs.map((e) {
        log("logging from getOrders${e.id}");
        return {
          'orderId': e.id,
          'user': e.data()['user'],
          'products': e.data()['products'],
          'orderValue': e.data()['orderValue'],
          'orderStatus': e.data()['orderStatus'],
          'orderDate': e.data()['orderDate'],
          'imageUrl': e.data()['imageUrl'],
        };
      }).toList();
      log(data.toString());
      return List.from(data);
    });
  }
}
