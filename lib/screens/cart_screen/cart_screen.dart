import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/cart_controller_getx.dart';

import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/util/firebase_auth_helper.dart';
import 'package:mcemeurckart/util/verify_order_utility.dart';

import 'widgets/cart_product_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(
                left: Sizes.p8,
              ),
              child: Text(
                'Cart',
                style: Get.textTheme.headlineSmall,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Sizes.p24,
                ),
                child: PrimaryIconButton(
                  icon: AppIcons.favoriteIcon,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: Sizes.p12,
              right: Sizes.p12,
            ),
            child: GetBuilder<CartController>(builder: (cartController) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                    visible: cartController.cartItems.isNotEmpty,
                    replacement: EmptyStateCard(
                      hasDescription: false,
                      cardImage: AppAssets.wishlistEmpty,
                      cardTitle: 'Uh Oh! You have nothing in your Cart',
                      cardColor: AppColors.red400,
                      buttonText: 'Add items to your Cart',
                      buttonPressed: () {
                        Get.offAllNamed(AppRoutes.baseRoute);
                      },
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * .75,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.p2,
                              vertical: Sizes.p8,
                            ),
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: cartController.cartItems.length,
                            separatorBuilder: (_, index) => gapH8,
                            itemBuilder: (_, index) => CartProductCard(
                              product: cartController.cartItems[index].product,
                              quantity:
                                  cartController.cartItems[index].quantity,
                              increment: () => cartController.increaseQuantity(
                                  cartController
                                      .cartItems[index].product['index']),
                              decrement: () => cartController.decreaseQuantity(
                                  cartController
                                      .cartItems[index].product['index']),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.p12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Cart total',
                                style: Get.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.neutral600,
                                ),
                              ),
                              Text(
                                '₹${cartController.getTotal()} /-',
                                style: Get.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        gapH12,
                        PrimaryButton(
                            buttonColor: AppColors.neutral800,
                            buttonLabel: 'Checkout',
                            onPressed: () async {
                              try {
                                final products = cartController.cartItems
                                    .map((cartItem) => {
                                          'index': cartItem.product['index'],
                                          'quantity': cartItem.quantity,
                                          'monthlyLimit': cartItem
                                                  .product['monthlyLimit'] ??
                                              false
                                        })
                                    .toList();
                                final token = await FirebaseAuthHelper
                                        .firebaseAuthHelper
                                        .firebaseAuth
                                        .currentUser
                                        ?.getIdToken() ??
                                    '';
                                log(token.toString());
                                final res = await verifyOrder(
                                    token, {'products': products});
                                log(res.toString());
                              } catch (e) {
                                log("from cart screen");
                                log(e.toString());
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
