import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/category_controller_getx.dart';
import 'package:mcemeurckart/controller/generics_controller_getx.dart';
import 'package:mcemeurckart/controller/user_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key, required this.controller});

  final PageController controller;
  final generics = Get.find<GenericsController>().generics;
  final categories = Get.find<CategoriesController>().categories;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 50.0,
              ),

              //User Information.
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 50.0,
                      child: CachedNetworkImage(
                          imageUrl: Get.find<UserController>()
                                  .user['displayPicture'] ??
                              ''),
                    ),
                    gapH8,
                    Text(
                      Get.find<UserController>().user['displayName'],
                      style: TextStyle(
                          fontSize: 20.0,
                          color: AppColors.neutral900,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: generics.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(generics[index]['title']),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories
                          .where((element) =>
                              element['generic'] == generics[index]['id'] &&
                              element['isRoot'])
                          .length,
                      itemBuilder: (context, idx) {
                        return ListTile(
                            contentPadding: const EdgeInsets.only(left: 40.0),
                            title: Text(categories
                                .where((element) =>
                                    element['generic'] ==
                                        generics[index]['id'] &&
                                    element['isRoot'])
                                .toList()[idx]['title']),
                            onTap: () {
                              Scaffold.of(context).closeDrawer();
                              Get.toNamed(AppRoutes.productsScreenRoute,
                                  arguments: categories
                                      .where((element) =>
                                          element['generic'] ==
                                              generics[index]['id'] &&
                                          element['isRoot'])
                                      .toList()[idx]);
                            });
                      },
                    )
                  ],
                );
              },
            ),
            ListTile(
              title: const Text('Orders'),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                Get.toNamed(AppRoutes.ordersRoute);
              },
            ),
            ListTile(
              title: const Text('Wishlist'),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                Get.toNamed(AppRoutes.wishlistRoute);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                Get.toNamed(AppRoutes.profileRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
