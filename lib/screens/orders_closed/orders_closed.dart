import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/routes/app_routes.dart';

class OrdersClosed extends StatelessWidget {
  const OrdersClosed({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        gapH16,
        const SvgAsset(assetPath: AppAssets.storeImage),
        Text(
          'URC is closed at the moment. It will open according to the schedule',
          style: Get.textTheme.bodyMedium?.copyWith(
            color: AppColors.neutral600,
            fontWeight: Fonts.interRegular,
          ),
        ),
      ],
    ))));
  }
}
