import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/cart_controller_getx.dart';
import 'package:mcemeurckart/controller/wishlist_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

import 'widgets/wishlist_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(
                left: Sizes.p8,
              ),
              child: Text(
                AppTitles.whishlistTitle,
                style: Get.textTheme.headlineSmall,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Sizes.p24,
                ),
                child: PrimaryIconButton(
                  icon: AppIcons.shoppingCartIcon,
                  onPressed: () {
                    Get.toNamed(AppRoutes.cartRoute);
                  },
                ),
              ),
            ],
          ),
        ],
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: Sizes.p24,
              right: Sizes.p24,
              bottom: Sizes.p80,
            ),
            child: GetBuilder<WishlistController>(
              builder: (wishlistController) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: wishlistController.wishlistItems.isNotEmpty,
                      replacement: EmptyStateCard(
                        hasDescription: false,
                        cardImage: AppAssets.wishlistEmpty,
                        cardTitle: 'Uh Oh! You have nothing in your wishlist',
                        cardColor: AppColors.purple300,
                        buttonText: 'Add items to your wishlist',
                        buttonPressed: () {
                          Get.offAllNamed(AppRoutes.baseRoute);
                        },
                      ),
                      child: SizedBox(
                        height: Get.height * .85,
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.p6,
                          ),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: wishlistController.wishlistItems.length,
                          separatorBuilder: (_, index) => gapH4,
                          itemBuilder: (_, index) => WishlistCard(
                            listName: wishlistController.wishlistItems[index]
                                    ['index']
                                .toString(),
                            imageUrl: wishlistController.wishlistItems[index]
                                ['imageUrl'],
                            itemName: wishlistController.wishlistItems[index]
                                ['title'],
                            price: wishlistController.wishlistItems[index]
                                    ['price']
                                .toDouble(),
                            onCardTap: () {
                              Get.toNamed(
                                AppRoutes.productItemRoute,
                                arguments:
                                    wishlistController.wishlistItems[index],
                              );
                            },
                            onAddToCart: () {
                              Get.find<CartController>().addToCart(
                                  wishlistController.wishlistItems[index]
                                      ['index']);

                              Get.find<WishlistController>().removeFromWishlist(
                                  wishlistController.wishlistItems[index]);

                              Get.snackbar("", "Item moved to cart",
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 3));
                            },
                            onCloseTap: () {
                              Get.find<WishlistController>().removeFromWishlist(
                                  wishlistController.wishlistItems[index]);

                              Get.snackbar("", "Item removed from wishlist",
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: const Duration(seconds: 3));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
