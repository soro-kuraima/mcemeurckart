import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/category_controller_getx.dart';
import 'package:mcemeurckart/controller/products_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/screens/categories_screen/widgets/stagerred_category_card.dart';
import 'package:mcemeurckart/screens/home_screen/widgets/deals_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final rootCategory = Get.arguments;

  final List<dynamic> categories = [
    ...Get.find<CategoriesController>().categories.where(
        (element) => Get.arguments['subCategories']?.contains(element['id']))
  ].obs;

  final popularCategoriesColors = [
    AppColors.purple300,
    AppColors.blue300,
    AppColors.red300,
    AppColors.green300,
  ];

  final trendingInGamingImages = [
    // 'https://tech4u.co.mz/wp-content/uploads/2023/01/cq5dam.web_.1280.1280.png',
    // 'https://images.csmonitor.com/csm/2014/06/hobbit.png?alias=standard_900x600nc',
    'https://icegames.co/image/cache/catalog/1212121219/dualsense-ps5-controller-midnight-black-accessory-front-550x550.png',
    // 'https://images.csmonitor.com/csm/2014/06/hobbit.png?alias=standard_900x600nc',
    'https://multimedia.bbycastatic.ca/multimedia/products/1500x1500/171/17145/17145330_8.png',
    'https://res-4.cloudinary.com/grover/image/upload/v1630929070/vyqf9rdpila7hephrw75.png',
    // 'https://media2.sport-bittl.com/images/product_images/original_images/27826167676a_Birkenstock_Arizona_Schuh_He_schwarz.png',
  ];

  final trendingInReadingImages = [
    'https://bookbins.in/wp-content/uploads/2023/01/Cant-Hurt-Me-David-Goggins-Buy-Online-Bookbins-1.png',
    'https://bookbins.in/wp-content/uploads/2022/02/How-To-Stop-Worrying-And-Start-Living-Dale-Carnegie-Buy-Online-Bookbins-1.png',
    'https://assets.target.com.au/transform/025d6e4b-5f99-4ac9-ab9a-ee6b4113639e/65141670_IMG_001?io=transform:extend,width:700,height:800&output=jpeg&quality=80',
    'https://bookbins.in/wp-content/uploads/2021/11/Who-Moved-My-Cheese-Dr.Spencer-Johnson-Buy-Online-Bookbins-1.png',
  ];

  RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    log(categories.toString());
    List<dynamic> products = [
      ...Get.find<ProductsController>().products.where(
          (element) => categories[0]['products']?.contains(element['index']))
    ].obs;
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
            child: Expanded(
              child: Obx(() => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NavigationRail(
                        backgroundColor: AppColors.blue100,
                        selectedIndex: _selectedIndex.value,
                        onDestinationSelected: (int index) {
                          products = [
                            ...Get.find<ProductsController>().products.where(
                                (element) => categories[index]['products']
                                    ?.contains(element['index']))
                          ];
                          _selectedIndex.value = index;
                        },
                        labelType: NavigationRailLabelType.all,
                        destinations: [
                          ...List.generate(
                              categories.length,
                              (index) => NavigationRailDestination(
                                    icon: CachedNetworkImage(
                                      imageUrl: categories[index]['imageUrl'],
                                      height: 25,
                                      width: 25,
                                    ),
                                    label: SizedBox(
                                      width: Sizes.p32,
                                      child: Center(
                                        child: Text(
                                          categories[index]['title'],
                                          style: TextStyle(
                                              color: AppColors.neutral800,
                                              fontSize: Sizes.p12),
                                          // Use ellipsis to indicate overflow
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  )),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(
                            Sizes.p24,
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
                                itemBuilder: (_, index) => DealsCard(
                                  title: products[index]['title'],
                                  price: products[index]['price'],
                                  imageUrl: products[index]['imageUrl'],
                                  onCardTap: () {
                                    Get.toNamed(AppRoutes.productItemRoute,
                                        arguments: products[index]);
                                  },
                                  onLikeTap: () {},
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
      ),
    );
  }
}
