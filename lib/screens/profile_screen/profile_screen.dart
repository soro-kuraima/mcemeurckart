import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

import 'widgets/account_card.dart';
import 'widgets/profile_biography_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final accountSettings = [
    'Orders',
    'Wishlist',
    'Payment Methods',
    'Address',
  ];

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
                AppTitles.profileTitle,
                style: Get.textTheme.headlineSmall,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Sizes.p24,
                ),
                child: PrimaryIconButton(
                  icon: AppIcons.settingsIcon,
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
              left: Sizes.p24,
              right: Sizes.p24,
              bottom: Sizes.p32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileBiography(
                  userName: 'Abhishek Sharma',
                  userBiography: 'Bio of Abhishek Sharma',
                  editFunction: () {},
                ),
                gapH24,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Account',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    PrimaryTextButton(
                      buttonLabel: 'View all',
                      onPressed: () {},
                    ),
                  ],
                ),
                gapH16,
                SizedBox(
                  height: Get.size.height * .15,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: accountSettings.length,
                      separatorBuilder: (_, index) => gapW16,
                      itemBuilder: (_, index) {
                        if (index == 0) {
                          return AccountCard(
                            text: accountSettings[index],
                            onCardTap: () {
                              Get.toNamed(AppRoutes.ordersRoute);
                            },
                          );
                        }
                        if (index == 1) {
                          return AccountCard(
                            text: accountSettings[index],
                            onCardTap: () {
                              Get.toNamed(AppRoutes.wishlistRoute);
                            },
                          );
                        }

                        return AccountCard(
                          text: accountSettings[index],
                          onCardTap: () {},
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
