import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/category_controller_getx.dart';
import 'package:mcemeurckart/controller/generics_controller_getx.dart';
import 'package:mcemeurckart/controller/products_controller_getx.dart';
import 'package:mcemeurckart/controller/wishlist_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/screens/home_screen/widgets/deals_card.dart';
import 'package:mcemeurckart/screens/home_screen/widgets/home_category_card.dart';
import 'package:mcemeurckart/screens/home_screen/widgets/main_card.dart';

enum ScrollDirection { forward, backward }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  void _scrollToTheNextItemView({
    ScrollDirection scrollDirection = ScrollDirection.forward,
  }) async {
    if (scrollDirection == ScrollDirection.forward) {
      if (_scrollController.position.pixels <
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        await _scrollController.animateTo(
          _scrollController.position.pixels + 150,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.easeOut,
        );
      }
    } else {
      if (_scrollController.position.pixels >
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        await _scrollController.animateTo(
          _scrollController.position.pixels - 150,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final trendingCardColors = [
    AppColors.blue300,
    AppColors.green300,
    AppColors.purple300,
    AppColors.red300,
    AppColors.yellow300,
  ];

  final categoriesColors = [
    AppColors.red300,
    AppColors.purple300,
    AppColors.blue300,
    AppColors.green300,
  ];

  @override
  Widget build(BuildContext context) {
    //const isLoggedIn = true;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            leading: const Padding(
              padding: EdgeInsets.only(
                left: Sizes.p24,
                top: Sizes.p16,
                bottom: Sizes.p16,
              ),
              child: SvgAsset(
                assetPath: AppAssets.appLogoBlackSmall,
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
                    Get.toNamed(
                      AppRoutes.cartRoute,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: GetBuilder<GenericsController>(
            builder: (genericsController) {
              return GetBuilder<CategoriesController>(
                  builder: (categoriesController) {
                return GetBuilder<ProductsController>(
                  builder: (productsController) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.only(
                        top: Sizes.p32,
                      ),
                      child: Column(
                        children: [
                          // * Just For You
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.p24,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Most Ordered',
                                    style: Get.textTheme.headlineSmall,
                                  ),
                                ),
                                PrimaryIconButton(
                                  icon: AppIcons.iOSLeftArrowIcon,
                                  onPressed: () => _scrollToTheNextItemView(
                                      scrollDirection:
                                          ScrollDirection.backward),
                                ),
                                PrimaryIconButton(
                                  icon: AppIcons.iOSRightArrowIcon,
                                  onPressed: _scrollToTheNextItemView,
                                ),
                              ],
                            ),
                          ),
                          gapH16,
                          SizedBox(
                            height: Sizes.deviceHeight * .4,
                            child: ListView.separated(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.p24,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  min(16, productsController.products.length),
                              separatorBuilder: (_, index) => gapW16,
                              itemBuilder: (_, index) {
                                if (index % 2 == 0) {
                                  return MainCard(
                                    cardColor: trendingCardColors[
                                        index % trendingCardColors.length],
                                    title: productsController.products[index]
                                        ['title'],
                                    price: productsController.products[index]
                                        ['price'],
                                    imageUrl: productsController.products[index]
                                        ['imageUrl'],
                                    onPressed: () => Get.toNamed(
                                      AppRoutes.productItemRoute,
                                      arguments:
                                          productsController.products[index],
                                    ),
                                    onLikeTap: () {
                                      Get.find<WishlistController>()
                                          .addToWishlist(productsController
                                              .products[index]);
                                    },
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                          gapH32,
                          // * Deals
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.p24,
                              vertical: Sizes.p16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Your favorites',
                                    style: Get.textTheme.headlineSmall,
                                  ),
                                ),
                                PrimaryTextButton(
                                  buttonLabel: 'View all',
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                          gapH16,
                          SizedBox(
                            height: Sizes.deviceHeight * .3,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.p24,
                                ),
                                itemCount:
                                    min(16, productsController.products.length),
                                separatorBuilder: (_, __) => gapW16,
                                itemBuilder: (_, index) {
                                  if (index % 2 != 0) {
                                    return DealsCard(
                                      title: productsController.products[index]
                                          ['title'],
                                      price: productsController.products[index]
                                          ['price'],
                                      imageUrl: productsController
                                          .products[index]['imageUrl'],
                                      onCardTap: () => Get.toNamed(
                                        AppRoutes.productItemRoute,
                                        arguments:
                                            productsController.products[index],
                                      ),
                                      onLikeTap: () {
                                        Get.find<WishlistController>()
                                            .addToWishlist(productsController
                                                .products[index]);
                                      },
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                }),
                          ),
                          gapH32,
                          // * Cards Section
                          GridView.builder(
                            padding: const EdgeInsets.fromLTRB(
                              Sizes.p24,
                              Sizes.p16,
                              Sizes.p24,
                              Sizes.p4,
                            ),
                            itemCount: min(
                                4, categoriesController.rootCategories.length),
                            primary: false,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              //mainAxisSpacing: Sizes.p16,
                              //crossAxisSpacing: Sizes.p12,
                              childAspectRatio: 9 / 10,
                            ),
                            itemBuilder: (_, index) => HomeCategoryCard(
                              color: categoriesColors[index],
                              title: index == 3
                                  ? "View All"
                                  : categoriesController.rootCategories[index]
                                      ['title'],
                              onTap: () {
                                if (index == 3) {
                                  Get.toNamed(
                                    AppRoutes.categoriesRoute,
                                  );
                                } else {
                                  Get.toNamed(
                                    AppRoutes.subCategoriesRoute,
                                    arguments: categoriesController
                                        .rootCategories[index],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
