import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/category_controller_getx.dart';
import 'package:mcemeurckart/controller/products_controller_getx.dart';
import 'package:mcemeurckart/controller/wishlist_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

import 'widgets/products_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final rootCategory = Get.arguments;

  final List<dynamic> categories = [
    ...Get.find<CategoriesController>().categories.where((element) {
      if (Get.arguments['hasProducts'] == true) {
        return Get.arguments['id'] == element['id'];
      } else {
        return Get.arguments['subCategories']?.contains(element['id']);
      }
    })
  ].obs;

  List<dynamic> products = [
    ...Get.find<ProductsController>().products.where((element) => [
          ...Get.find<CategoriesController>().categories.where((element) {
            if (Get.arguments['hasProducts'] == true) {
              return Get.arguments['id'] == element['id'];
            } else {
              return Get.arguments['subCategories']?.contains(element['id']);
            }
          })
        ][0]['products']
            ?.contains(element['index']))
  ].obs;

  final popularCategoriesColors = [
    AppColors.purple300,
    AppColors.blue300,
    AppColors.red300,
    AppColors.green300,
  ];
  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    log(products.toString());
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) => [
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.p8,
                ),
                child: Text(
                  rootCategory['title'],
                  style: TextStyle(
                      color: AppColors.neutral800, fontSize: Sizes.p20),
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
            child: Obx(() => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    categories.length >= 2
                        ? NavigationRail(
                            backgroundColor: AppColors.blue100,
                            indicatorColor: AppColors.blue500,
                            indicatorShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.p8),
                              ),
                            ),
                            selectedIndex: _selectedIndex.value,
                            onDestinationSelected: (int index) {
                              products = [
                                ...Get.find<ProductsController>()
                                    .products
                                    .where((element) => categories[index]
                                            ['products']
                                        ?.contains(element['index']))
                              ];
                              _selectedIndex.value = index;
                            },
                            selectedIconTheme: IconThemeData(
                              color: AppColors.neutral800,
                              size: Sizes.p32,
                            ),
                            labelType: NavigationRailLabelType.all,
                            destinations: [
                              ...List.generate(
                                  categories.length,
                                  (index) => NavigationRailDestination(
                                        icon: CachedNetworkImage(
                                          imageUrl: categories[index]
                                              ['imageUrl'],
                                          height: 40,
                                          width: 40,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        selectedIcon: CachedNetworkImage(
                                          imageUrl: categories[index]
                                              ['imageUrl'],
                                          height: 40,
                                          width: 40,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppColors.neutral500,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        label: SizedBox(
                                          width: Sizes.p80,
                                          child: Center(
                                            child: Text(
                                              categories[index]['title'],
                                              style: TextStyle(
                                                  color: AppColors.neutral800,
                                                  fontSize: Sizes.p12,
                                                  fontWeight: FontWeight.bold),
                                              // Use ellipsis to indicate overflow
                                              softWrap: true,
                                              textWidthBasis:
                                                  TextWidthBasis.longestLine,
                                            ),
                                          ),
                                        ),
                                      )),
                            ],
                          )
                        : const SizedBox.shrink(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(
                          Sizes.p8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GridView.builder(
                              itemCount: products.length,
                              primary: false,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // mainAxisSpacing: Sizes.p16,
                                crossAxisSpacing: Sizes.p6,
                                childAspectRatio: 9 / 10,
                              ),
                              itemBuilder: (_, index) => ProductsCard(
                                title: products[index]['title'],
                                price: products[index]['price'],
                                height: Sizes.deviceHeight * 0.6,
                                imageUrl: products[index]['imageUrl'],
                                onCardTap: () {
                                  Get.toNamed(AppRoutes.productItemRoute,
                                      arguments: products[index]);
                                },
                                onLikeTap: () {
                                  Get.find<WishlistController>()
                                          .wishlist
                                          .contains(products[index]['index'])
                                      ? Get.find<WishlistController>()
                                          .removeFromWishlist(products[index])
                                      : Get.find<WishlistController>()
                                          .addToWishlist(products[index]);

                                  Get.forceAppUpdate();
                                },
                                isWishlisted: Get.find<WishlistController>()
                                    .wishlist
                                    .contains(products[index]['index']),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
