import "package:flutter/material.dart";
import "package:get/get.dart";

import "package:mcemeurckart/screens/base_screen/base_screen.dart";
import "package:mcemeurckart/screens/cart_screen/cart_screen.dart";
import "package:mcemeurckart/screens/categories_screen/categories_screen.dart";
import "package:mcemeurckart/screens/checkout_screen/checkout_confirmation_screen.dart";
import "package:mcemeurckart/screens/checkout_screen/checkout_screen.dart";
import "package:mcemeurckart/screens/home_screen/home_screen.dart";
import "package:mcemeurckart/screens/order_item_screen/order_item_screen.dart";
import "package:mcemeurckart/screens/orders_screen/orders_screen.dart";
import 'package:mcemeurckart/screens/product_item_screen/product_item_screen.dart';
import "package:mcemeurckart/screens/products_screen/products_screen.dart";
import "package:mcemeurckart/screens/search_screen/search_screen.dart";
import "package:mcemeurckart/screens/sub_categories_screen/sub_categories_screen.dart";
import "package:mcemeurckart/screens/wishlist_screen/wishlist_screen.dart";

abstract class AppPages {
  static final pages = <GetPage>[
    /* 
    * ===== Auth Pages =====
*/

    GetPage(
      name: AppRoutes.baseRoute,
      page: () => const BaseScreen(),
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),
    /* 
    * ===== Home Page =====
     */
    GetPage(
      name: AppRoutes.homeRoute,
      page: () => const HomeScreen(),
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),
    /* 
    * ===== Product Details Pages =====
     */
    GetPage(
      name: AppRoutes.productItemRoute,
      page: () => const ProductItemScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transition: Transition.downToUp,
    ),

    //* ==== In App Pages ======
    GetPage(
      name: AppRoutes.categoriesRoute,
      page: () => const CategoriesScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),

    GetPage(
        name: AppRoutes.productsScreenRoute,
        page: () => const ProductsScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transition: Transition.rightToLeft),

    GetPage(
      name: AppRoutes.searchRoute,
      page: () => const SearchScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),

    /* wishlist and cart */
    GetPage(
      name: AppRoutes.cartRoute,
      page: () => const CartScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.wishlistRoute,
      page: () => const WishlistScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),

    /*checkout screens */

    GetPage(
      name: AppRoutes.checkoutRoute,
      page: () => const CheckoutScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.checkoutConfirmationRoute,
      page: () => const CheckoutConfirmationScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.ordersRoute,
      page: () => const OrdersScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.orderItemRoute,
      page: () => const OrderItem(),
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      transition: Transition.rightToLeft,
    ),
  ];
}

abstract class AppRoutes {
  static const signInRoute = '/signIn';
  static const signUpRoute = '/signUp';

  static const baseRoute = '/';
  static const homeRoute = '/home';
  static const cartRoute = '/cart';
  static const categoriesRoute = '/categories';
  static const subCategoriesRoute = '/subCategories';
  static const checkoutRoute = '/checkout';
  static const checkoutConfirmationRoute = '/checkoutConfirmation';
  static const productsScreenRoute = '/productsScreen';
  static const productItemRoute = '/productItem';
  static const profileRoute = '/profile';
  static const ordersRoute = '/orders';
  static const orderItemRoute = '/orderItem';
  static const searchRoute = '/search';
  static const wishlistRoute = '/wishlist';
  static const deliveryRoute = '/delivery';
}
