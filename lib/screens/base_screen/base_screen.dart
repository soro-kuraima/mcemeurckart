import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/controller/cart_controller_getx.dart';
import 'package:mcemeurckart/controller/category_controller_getx.dart';
import 'package:mcemeurckart/controller/generics_controller_getx.dart';
import 'package:mcemeurckart/controller/orders_controller_getx.dart';
import 'package:mcemeurckart/controller/products_controller_getx.dart';
import 'package:mcemeurckart/controller/wishlist_controller_getx.dart';
import 'package:mcemeurckart/screens/orders_screen/orders_screen.dart';
import 'package:mcemeurckart/screens/home_screen/home_screen.dart';
import 'package:mcemeurckart/screens/profile_screen/profile_screen.dart';
import 'package:mcemeurckart/screens/wishlist_screen/wishlist_screen.dart';
import 'widgets/custom_bottom_navbar.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final pageController = PageController();
  final screens = [
    const HomeScreen(),
    const WishlistScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<WishlistController>(
        builder: (wishlistController) {
          return GetBuilder<CartController>(
            builder: (cartController) {
              return GetBuilder<OrdersController>(
                builder: (ordersController) {
                  return Scaffold(
                    bottomNavigationBar: CustomBottomNavBar(
                      screenController: pageController,
                    ),
                    body: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: screens,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
