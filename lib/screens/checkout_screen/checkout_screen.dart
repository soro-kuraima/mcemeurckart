import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/cart_controller_getx.dart';
import 'package:mcemeurckart/controller/user_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
import 'package:mcemeurckart/screens/checkout_screen/widgets/order_summary.dart';
import 'package:mcemeurckart/util/firestore_helper.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              centerTitle: true,
              title: Text(
                AppTitles.checkoutTitle,
                style: Get.textTheme.headlineSmall,
              ),
            ),
          ],
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SizedBox(
              height: Sizes.deviceHeight * 0.8,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.p24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Method',
                          style: Get.textTheme.displayLarge,
                        ),
                      ],
                    ),
                    gapH16,
                    Padding(
                      padding: const EdgeInsets.only(left: Sizes.p32),
                      child: RadioMenuButton(
                          value: 'cod',
                          groupValue: 'cod',
                          onChanged: (value) {},
                          child: const Text('Pay on delivery')),
                    ),
                    gapH24,
                    const CustomDivider(hasText: false),
                    gapH24,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Address',
                          style: Get.textTheme.displayLarge,
                        ),
                      ],
                    ),
                    gapH16,
                    Text(
                      Get.find<UserController>().user['displayName'],
                      style: Get.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapH8,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Get.find<UserController>().user['address'],
                        style: Get.textTheme.displayLarge?.copyWith(
                          color: AppColors.neutral600,
                        ),
                      ),
                    ),
                    gapH24,
                    const CustomDivider(hasText: false),
                    gapH24,
                    Text(
                      'Order Summary',
                      style: Get.textTheme.displayLarge,
                    ),
                    gapH16,
                    GetBuilder<CartController>(builder: (cartController) {
                      return ListView.separated(
                        shrinkWrap: true,
                        primary: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.p2,
                          vertical: Sizes.p10,
                        ),
                        itemCount: cartController.cartItems.length,
                        separatorBuilder: (_, index) => gapH8,
                        itemBuilder: (_, index) => OrderSummary(
                          cartItem: cartController.cartItems[index],
                        ),
                      );
                    }),
                    gapH24,
                    const CustomDivider(hasText: false),
                    gapH24,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery',
                          style: Get.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Free',
                          style: Get.textTheme.titleLarge?.copyWith(
                            fontWeight: Fonts.interRegular,
                          ),
                        ),
                      ],
                    ),
                    gapH8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: Get.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹ ${Get.find<CartController>().getTotal()} /-',
                          style: Get.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    gapH24,
                    const CustomDivider(hasText: false),
                    PrimaryButton(
                      buttonColor: AppColors.neutral800,
                      buttonLabel: 'Place order',
                      onPressed: () async {
                        int total = Get.find<CartController>().getTotal();
                        await FireBaseStoreHelper.placeOrder(total);
                        Get.offAllNamed(
                          AppRoutes.checkoutConfirmationRoute,
                        );
                      },
                    ),
                    gapH16,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
