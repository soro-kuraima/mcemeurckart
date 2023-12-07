import 'dart:developer';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _orderEstimatedTime = DateTime.now().add(
      const Duration(minutes: 60),
    );
    log(DateTime.now().toString());
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
                    'Your order has been placed successfully. You can pick up your order from URC at ${_orderEstimatedTime.hour}:${_orderEstimatedTime.minute} today.',
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
