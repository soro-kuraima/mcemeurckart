import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseStoreHelper {
  FireBaseStoreHelper._();

  static final FireBaseStoreHelper fireBaseStoreHelper =
      FireBaseStoreHelper._();
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> insert({required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> k =
        await db.collection('counter').doc('CounterKeeper').get();
    int id = k['id'];
    int len = k['lenght'];
    await db.collection("product").doc("${++id}").set(data);
    db.collection("product").doc("$id").update({"Uid": id});
    db
        .collection("counter")
        .doc("CounterKeeper")
        .update({'id': id, 'lenght': ++len});
  }

  Future<void> update({required Map<String, dynamic> data}) async {
    String id = data['Uid'].toString();
    db.collection('product').doc(id).set(data);
  }

  Delete({required int Uid}) async {
    String id = Uid.toString();
    await db.collection("product").doc(id).delete();

    DocumentSnapshot<Map<String, dynamic>> k =
        await db.collection("counter").doc("CounterKeeper").get();

    int length = k['lenght'];

    await db
        .collection("counter")
        .doc("CounterKeeper")
        .update({"lenght": --length});
  }

  Future<void> cartInsert({required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> k =
        await db.collection('cartCounter').doc('cartCounterKeeper').get();
    int id = k['id'];
    int len = k['lenght'];
    await db.collection("cartProduct").doc("${++id}").set(data);
    db.collection("cartProduct").doc("$id").update({"Uid": id});
    db
        .collection("cartCounter")
        .doc("cartCounterKeeper")
        .update({'id': id, 'lenght': ++len});
  }

  Future<void> cartUpdate({required Map<String, dynamic> data}) async {
    String id = data['Uid'].toString();
    db.collection('cartProduct').doc(id).set(data);
  }

  cartDelete({required int Uid}) async {
    String id = Uid.toString();
    await db.collection("cartProduct").doc(id).delete();

    DocumentSnapshot<Map<String, dynamic>> k =
        await db.collection("cartCounter").doc("cartCounterKeeper").get();

    int length = k['lenght'];

    await db
        .collection("cartCounter")
        .doc("cartCounterKeeper")
        .update({"lenght": --length});
  }

  Future<void> imageInsert({required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> k =
        await db.collection('imgCounter').doc('imageCounterKeeper').get();
    int id = k['id'];
    int len = k['lenght'];
    await db.collection("UserImage").doc("${++id}").set(data);
    db.collection("UserImage").doc("$id").update({"Uid": id});
    db
        .collection("imgCounter")
        .doc("imageCounterKeeper")
        .update({'id': id, 'lenght': ++len});
  }

  static final categoriesRef = db.collection('categories');
  static final productsRef = db.collection('products');

  static final generics = categoriesRef.doc('generics');
  static final rootCategories = categoriesRef.doc('root-categories');
  static final productCategories = categoriesRef.doc('product-categories');

  static Future<Map<String, dynamic>> getGenerics() async {
    Map<String, dynamic> res = {};
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await generics.get();
      res = documentSnapshot.data()!;
    } catch (e) {
      print(e);
    }
    return res;
  }

  static Future<Map<String, dynamic>> getRootCategories() async {
    Map<String, dynamic> res = {};
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await rootCategories.get();
      res = documentSnapshot.data()!;
    } catch (e) {
      print(e);
    }
    return res;
  }

  static Future<Map<String, dynamic>> getProductCategories() async {
    Map<String, dynamic> res = {};
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await productCategories.get();
      res = documentSnapshot.data()!;
    } catch (e) {
      print(e);
    }
    return res;
  }

  static Future<List<Map<String, dynamic>>> getProducts() async {
    List<Map<String, dynamic>> products = [];
    try {
      final response = await productsRef.get();
      if (response.docs.isNotEmpty) {
        for (final item in response.docs) {
          products.add(item.data());
        }
      }
    } catch (e) {
      print(e);
    }
    return products;
  }

  static Future<Map<String, dynamic>> getProduct(int productId) async {
    Map<String, dynamic> res = {};
    final product = productsRef.doc(productId.toString());
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await product.get();
      res = documentSnapshot.data()!;
    } catch (e) {
      print(e);
    }
    return res;
  }
}
