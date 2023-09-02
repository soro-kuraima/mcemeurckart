import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/cart_controller_getx.dart';
import 'package:mcemeurckart/models/products_model.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/screens/cart_screen/widgets/cart_product_card.dart';

import 'widgets/page_dots_secondary.dart';
import 'widgets/text_cropping_widget.dart';

class ProductItemScreen extends StatefulWidget {
  const ProductItemScreen({super.key});

  @override
  State<ProductItemScreen> createState() => _ProductItemScreenState();
}

class _ProductItemScreenState extends State<ProductItemScreen> {
  final currentIndex = 0.obs;

  final pageController = PageController(initialPage: 0);

  Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              SlideTransition(
            position: Tween(
              begin: const Offset(0.0, 1.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          ),
          child: Container(
            key: const ValueKey<int>(0),
            padding: const EdgeInsets.fromLTRB(
              Sizes.p24,
              0,
              Sizes.p24,
              0,
            ),
            decoration: BoxDecoration(
              color: AppColors.yellow300,
            ),
            height: Sizes.deviceHeight * .12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Price',
                      style: Get.textTheme.titleLarge,
                    ),
                    gapH4,
                    // PRICE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //* SELLING PRICE
                            Text(
                              '₹ ${product.price} /-',
                              style: Get.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // TODO: isProductDiscount?
                            // gapW8,
                            // Text(
                            //   "\$99.99",
                            //   style: Get.textTheme.bodyMedium?.copyWith(
                            //     color: AppColors.neutral600,
                            //     fontWeight: Fonts.interRegular,
                            //     decoration: TextDecoration.lineThrough,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                gapW24,
                GetBuilder<CartController>(
                  builder: (cartController) {
                    return PrimaryButton(
                        buttonWidth: 150,
                        buttonHeight: 50,
                        buttonColor: AppColors.neutral800,
                        buttonLabel: 'Add to cart',
                        onPressed: () => {
                              cartController.addToCart(product.index),
                              showModalBottomSheet<void>(
                                // isScrollControlled: true,
                                isDismissible: true,
                                enableDrag: true, isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(Sizes.p16),
                                    topRight: Radius.circular(Sizes.p16),
                                  ),
                                ),
                                backgroundColor: AppColors.white,
                                context: context,
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    expand: false,
                                    maxChildSize: 1,
                                    initialChildSize:
                                        cartController.cartItems.length <= 3
                                            ? .4
                                            : .75,
                                    minChildSize:
                                        cartController.cartItems.length >= 3
                                            ? .3
                                            : .4,
                                    builder: (context, scrollController) =>
                                        Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: Sizes.p12,
                                      ),
                                      child: SizedBox(
                                        height: Sizes.deviceHeight,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: Sizes.p24,
                                              ),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () =>
                                                            Get.back(),
                                                        icon: const Icon(
                                                          Icons.close,
                                                        ),
                                                        color: AppColors
                                                            .neutral800,
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'Cart',
                                                    style: Get
                                                        .textTheme.displayLarge,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const CustomDivider(
                                              hasText: false,
                                            ),
                                            Expanded(
                                              flex: cartController
                                                          .cartItems.length <=
                                                      3
                                                  ? 2
                                                  : 7,
                                              child: GetBuilder<CartController>(
                                                builder: (cartController) {
                                                  return ListView.separated(
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    itemBuilder: (_, index) =>
                                                        CartProductCard(
                                                      product: cartController
                                                          .cartItems[index]
                                                          .product,
                                                      quantity: cartController
                                                          .cartItems[index]
                                                          .quantity,
                                                      increment: () =>
                                                          cartController
                                                              .increaseQuantity(
                                                                  cartController
                                                                      .cartItems[
                                                                          index]
                                                                      .product
                                                                      .index),
                                                      decrement: () =>
                                                          cartController
                                                              .decreaseQuantity(
                                                                  cartController
                                                                      .cartItems[
                                                                          index]
                                                                      .product
                                                                      .index),
                                                    ),
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            gapH28,
                                                    itemCount: cartController
                                                        .cartItems.length,
                                                  );
                                                },
                                              ),
                                            ),
                                            gapH12,
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: Sizes.p24,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Cart total',
                                                            style: Get.textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                              color: AppColors
                                                                  .neutral600,
                                                            ),
                                                          ),
                                                          gapH4,
                                                          GetBuilder<
                                                              CartController>(
                                                            builder:
                                                                (cartController) {
                                                              return Text(
                                                                '₹${cartController.getTotal()}',
                                                                style: Get
                                                                    .textTheme
                                                                    .titleSmall
                                                                    ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    gapW24,
                                                    Expanded(
                                                      flex: 3,
                                                      child: PrimaryButton(
                                                        buttonColor: AppColors
                                                            .neutral800,
                                                        buttonLabel: 'Checkout',
                                                        onPressed: () =>
                                                            Get.toNamed(
                                                          AppRoutes
                                                              .checkoutRoute,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            });
                  },
                )
              ],
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: AppColors.blue300,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: Sizes.p24,
                  ),
                  child: PrimaryIconButton(
                    icon: AppIcons.shoppingCartIcon,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //* Product Image
                  Stack(
                    children: [
                      Container(
                        height: Sizes.deviceHeight * .50,
                        color: AppColors.blue300,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: 1,
                          onPageChanged: (value) => setState(() {
                            currentIndex.value = value;
                          }),
                          itemBuilder: (_, index) => Container(
                            color: AppColors.blue300,
                            child: CachedNetworkImage(
                              imageUrl: product.imageUrl,
                              placeholder: (_, url) => const Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //* Page dots
                      Positioned(
                        bottom: 5,
                        left: 0,
                        right: 0,
                        child: PageDotsSecondary(
                          currentIndex: currentIndex.value,
                          countLength: 1,
                        ),
                      ),
                    ],
                  ),
                  //* Product Title
                  Padding(
                    padding: const EdgeInsets.all(
                      Sizes.p24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: Get.textTheme.headlineMedium,
                        ),
                        gapH12,
                        Text(
                          'Index No',
                          style: Get.textTheme.displayLarge,
                        ),
                        gapH8,
                        TextCroppingWidget(
                          text: product.index.toString(),
                        ),
                        gapH12,
                        //Text(
                        //'Generics',
                        //style: Get.textTheme.displayLarge,
                        //),
                        //gapH8,
                        //const TextCroppingWidget(
                        //  text: 'Gaming',
                        //),

                        gapH8,
                        //* Available Colors

                        Text(
                          'Description',
                          style: Get.textTheme.displayLarge,
                        ),
                        gapH12,
                        TextCroppingWidget(
                          text: product.description,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
