import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/products_controller_getx.dart';
import 'package:mcemeurckart/controller/wishlist_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/screens/products_screen/widgets/products_card.dart';

import 'widgets/custom_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController = TextEditingController();

  final products = [...Get.find<ProductsController>().products];

  final searchedProducts = [].obs;

  void searchProducts(String query) {
    searchedProducts.value = products.where((product) {
      final title = product['title'].toLowerCase();
      final category = product['category'].toLowerCase();
      final id = product['index'].toString().toLowerCase();
      final searchQuery = query.toLowerCase();

      return title.contains(searchQuery) ||
          category.contains(searchQuery) ||
          id.contains(searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: Sizes.p24,
          right: Sizes.p24,
          top: Sizes.p48,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearchBar(
                  searchController: SearchController,
                  onChanged: (value) {
                    log(value);
                    if (value.isEmpty) {
                      searchedProducts.clear();
                      return;
                    } else if (value.length > 1) {
                      log("search products called");
                      searchProducts(value);
                    }
                  }),
              gapH12,
              Obx(
                () => GridView.builder(
                  itemCount: searchedProducts.length,
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // mainAxisSpacing: Sizes.p16,
                    crossAxisSpacing: Sizes.p6,
                    childAspectRatio: 9 / 10,
                  ),
                  itemBuilder: (_, index) => Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Sizes.p10),
                      ),
                    ),
                    color: AppColors.neutral100,
                    child: SizedBox(
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(Sizes.p10),
                        ),
                        onTap: () {
                          Get.toNamed(AppRoutes.productItemRoute,
                              arguments: searchedProducts[index]);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Sizes.p10),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              Sizes.p8,
                              Sizes.p28,
                              Sizes.p8,
                              Sizes.p8,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: Sizes.p2,
                                      bottom: Sizes.p2,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: searchedProducts[index]
                                          ['imageUrl'],
                                      height: Sizes.deviceHeight * .7,
                                      width: Sizes.deviceWidth * .3,
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                      placeholder: (_, url) => Center(
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          valueColor: AlwaysStoppedAnimation(
                                            AppColors.neutral800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gapH4,
                                    SizedBox(
                                      width: Sizes.deviceWidth * .3,
                                      child: Text(
                                        searchedProducts[index]['title'],
                                        style: Get.textTheme.displayMedium,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    gapH8,
                                    Row(
                                      children: [
                                        Text(
                                          '₹${searchedProducts[index]['price']} /-',
                                          style: Get.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: AppColors.neutral600,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
