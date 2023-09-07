import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/controller/cart_controller_getx.dart';
import 'package:mcemeurckart/routes/app_routes.dart';
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
                      PrimaryOutlinedButton(
                        hasText: true,
                        title: 'Edit',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  gapH24,
                  const CustomDivider(hasText: false),
                  gapH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: Get.textTheme.displayLarge,
                      ),
                      PrimaryOutlinedButton(
                        hasText: true,
                        title: 'Edit',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  gapH16,
                  Text(
                    'Abhishek Sharma',
                    style: Get.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  gapH8,
                  Column(
                    children: [
                      Text(
                        "My address",
                        style: Get.textTheme.titleLarge?.copyWith(
                          color: AppColors.neutral600,
                        ),
                      ),
                    ],
                  ),
                  gapH24,
                  const CustomDivider(hasText: false),
                  gapH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: SecondaryTextField(
                          hintText: 'Promo Code',
                        ),
                      ),
                      gapW8,
                      Expanded(
                        child: PrimaryButton(
                          buttonHeight: 60,
                          buttonColor: AppColors.neutral800,
                          buttonLabel: 'Apply',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
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
                        '₹${Get.find<CartController>().getTotal()}',
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
    );
  }
}
