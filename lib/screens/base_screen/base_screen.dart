import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/cart_controller_getx.dart';
import 'package:mcemeurckart/controller/category_controller_getx.dart';
import 'package:mcemeurckart/controller/generics_controller_getx.dart';
import 'package:mcemeurckart/controller/orders_controller_getx.dart';
import 'package:mcemeurckart/controller/products_controller_getx.dart';
import 'package:mcemeurckart/controller/user_controller_getx.dart';
import 'package:mcemeurckart/controller/wishlist_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/screens/base_screen/widgets/custom_drawer.dart';
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

  RxBool searchToggle = false.obs;
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
                    appBar: AppBar(
                      backgroundColor: AppColors.blue100,
                      leading: Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.searchRoute);
                          },
                          icon: const Icon(Icons.search),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.sunny),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.cartRoute);
                          },
                          icon: const Icon(Icons.shopping_cart),
                        ),
                      ],
                    ),
                    bottomNavigationBar: CustomBottomNavBar(
                      screenController: pageController,
                    ),
                    drawer: CustomDrawer(
                      controller: pageController,
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
