import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/orders_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
                AppTitles.orderTitle,
                style: Get.textTheme.headlineSmall,
              ),
            ),
            actions: [],
          ),
        ],
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: Sizes.p24,
              right: Sizes.p24,
            ),
            child: GetBuilder<OrdersController>(
              builder: (ordersController) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: ordersController.orders.isNotEmpty,
                      replacement: EmptyStateCard(
                        hasDescription: false,
                        cardImage: AppAssets.wishlistEmpty,
                        cardTitle: 'Uh Oh! You have not placed any orders yet',
                        cardColor: AppColors.purple300,
                        buttonText: 'Shop Now',
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
                            itemCount: ordersController.orders.length,
                            separatorBuilder: (_, index) => gapH4,
                            itemBuilder: (_, index) {
                              return OrderCard(
                                  orderId: ordersController.orders[index]
                                          ['orderId'] ??
                                      '',
                                  imageUrl: ordersController.orders[index]
                                          ['imageUrl'] ??
                                      '',
                                  orderStatus: ordersController.orders[index]
                                          ['orderStatus'] ??
                                      '',
                                  orderValue: ordersController.orders[index]
                                          ['orderValue']
                                      .toString(),
                                  onCardTap: () async {
                                    await ordersController.setOrderItem(index);
                                    Get.toNamed(AppRoutes.orderItemRoute);
                                  });
                            }),
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
