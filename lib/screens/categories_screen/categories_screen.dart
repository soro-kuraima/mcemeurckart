import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/category_controller_getx.dart';
import 'package:mcemeurckart/controller/generics_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/screens/categories_screen/widgets/category_cartitem.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'widgets/stagerred_category_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final RxList<dynamic> categories =
      [...Get.find<CategoriesController>().rootCategories].obs;

  final RxList<dynamic> generics =
      [...Get.find<GenericsController>().generics].obs;

  final RxList<dynamic> selectedGenerics = [].obs;

  final popularCategoriesColors = [
    AppColors.purple300,
    AppColors.blue300,
    AppColors.red300,
    AppColors.green300,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.p8,
                ),
                child: Text(
                  AppTitles.categoriesTitle,
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
              padding: const EdgeInsetsDirectional.all(
                Sizes.p24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MultiSelectDropdown(
                      whenEmpty: 'Filters',
                      list: generics,
                      id: 'id',
                      label: 'title',
                      includeSelectAll: true,
                      numberOfItemsLabelToShow: 1,
                      checkboxFillColor: AppColors.blue300,
                      splashColor: AppColors.blue300,
                      initiallySelected: const [],
                      onChange: (selectedGenerics) {
                        categories.clear();
                        categories.addAll(
                          Get.find<CategoriesController>().rootCategories.where(
                              (element) => selectedGenerics.any(
                                  (selectedGeneric) =>
                                      element['generic'] ==
                                      selectedGeneric['id'])),
                        );
                        if (selectedGenerics.isEmpty) {
                          categories.addAll(
                            Get.find<CategoriesController>().rootCategories,
                          );
                        }
                        Get.forceAppUpdate();
                      }),
                  gapH40,
                  Obx(() => MasonryGridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        crossAxisSpacing: Sizes.p16,
                        mainAxisSpacing: Sizes.p16,
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (_, index) => StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: index.isEven ? 3 : 2,
                          child: StaggeredCard(
                            color: AppColors.blue500,
                            categoryName: categories[index]['title'],
                            imageUrl: categories[index]['imageUrl'],
                            onTap: () {
                              log(categories[index].toString());
                              Get.toNamed(
                                AppRoutes.productsScreenRoute,
                                arguments: categories[index],
                              );
                            },
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
