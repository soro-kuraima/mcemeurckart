import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:mcemeurckart/routes/route_middleware.dart";
import "package:mcemeurckart/screens/auth_screen/signin_screen.dart";
import "package:mcemeurckart/screens/auth_screen/signup_screen.dart";
import "package:mcemeurckart/screens/auth_screen/succesful_auth_request.dart";

import "package:mcemeurckart/screens/base_screen/base_screen.dart";
import "package:mcemeurckart/screens/cart_screen/cart_screen.dart";
import "package:mcemeurckart/screens/categories_screen/categories_screen.dart";
import "package:mcemeurckart/screens/checkout_screen/checkout_confirmation_screen.dart";
import "package:mcemeurckart/screens/checkout_screen/checkout_screen.dart";
import "package:mcemeurckart/screens/home_screen/home_screen.dart";
import "package:mcemeurckart/screens/loading_screen/loading_screen.dart";
import "package:mcemeurckart/screens/order_item_screen/order_item_screen.dart";
import "package:mcemeurckart/screens/orders_screen/orders_screen.dart";
import 'package:mcemeurckart/screens/product_item_screen/product_item_screen.dart';
import "package:mcemeurckart/screens/products_screen/products_screen.dart";
import "package:mcemeurckart/screens/profile_screen/edit_profile_screen.dart";
import "package:mcemeurckart/screens/profile_screen/profile_screen.dart";
import "package:mcemeurckart/screens/search_screen/search_screen.dart";
import "package:mcemeurckart/screens/wishlist_screen/wishlist_screen.dart";

abstract class AppPages {
  static const initial = AppRoutes.splashRoute;
  static final pages = <GetPage>[
    GetPage(name: AppRoutes.splashRoute, page: () => const LoadingScreen()),
    /* 
    * ===== Auth Pages =====

    
*/

    GetPage(name: AppRoutes.signInRoute, page: () => const SignInScreen()),
    GetPage(name: AppRoutes.signUpRoute, page: () => const SignUpScreen()),
    GetPage(
        name: AppRoutes.successfulAuthRequest,
        page: () => const SuccessfulAuthRequest()),
    GetPage(
        name: AppRoutes.baseRoute,
        page: () => const BaseScreen(),
        transitionDuration: const Duration(milliseconds: 2000),
        curve: Curves.easeOut,
        transition: Transition.rightToLeft,
        middlewares: [
          AuthMiddleware()
        ],
        children: [
          GetPage(
            name: AppRoutes.homeRoute,
            page: () => const HomeScreen(),
            transitionDuration: const Duration(milliseconds: 1000),
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

          GetPage(
            name: AppRoutes.profileRoute,
            page: () => const ProfileScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transition: Transition.rightToLeft,
          ),
          GetPage(
            name: AppRoutes.editProfileRoute,
            page: () => const EditProfileScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transition: Transition.rightToLeft,
          ),
        ]),
    /* 
    * ===== Home Page =====
     */
  ];
}

abstract class AppRoutes {
  static const splashRoute = '/splash';
  static const signInRoute = '/signIn';
  static const signUpRoute = '/signUp';
  static const successfulAuthRequest = '/successfulAuthRequest';
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
  static const editProfileRoute = '/editProfile';
  static const ordersRoute = '/orders';
  static const orderItemRoute = '/orderItem';
  static const searchRoute = '/search';
  static const wishlistRoute = '/wishlist';
  static const deliveryRoute = '/delivery';
}
