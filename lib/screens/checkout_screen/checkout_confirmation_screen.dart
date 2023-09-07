
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

class CheckoutConfirmationScreen extends StatefulWidget {
  const CheckoutConfirmationScreen({super.key});

  @override
  State<CheckoutConfirmationScreen> createState() =>
      _CheckoutConfirmationScreenState();
}

class _CheckoutConfirmationScreenState
    extends State<CheckoutConfirmationScreen> {
  // TODO: Checkout controller
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p24,
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  gapH280,
                  Text(
                    'Woohoo!',
                    style: Get.textTheme.headlineLarge,
                  ),
                  gapH24,
                  Text(
                    'Your order has been placed and you will get a shipping confirmation soon.',
                    style: Get.textTheme.displaySmall?.copyWith(
                      color: AppColors.neutral700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  gapH64,
                  PrimaryButton(
                    labelColor: AppColors.neutral800,
                    buttonLabel: 'Continue',
                    onPressed: () => Get.offAllNamed(
                      AppRoutes.baseRoute,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
