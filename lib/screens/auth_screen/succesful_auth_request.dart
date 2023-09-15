import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/common_widgets/svg_asset.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'package:mcemeurckart/screens/auth_screen/signin_screen.dart';

class SuccessfulAuthRequest extends StatelessWidget {
  const SuccessfulAuthRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Your request has been sent successfully',
          style: Get.textTheme.headlineSmall,
        ),
        gapH16,
        const SvgAsset(assetPath: AppAssets.mailboxImage),
        Text(
          'Please wait for the admin to approve your request',
          style: Get.textTheme.bodyMedium?.copyWith(
            color: AppColors.neutral600,
            fontWeight: Fonts.interRegular,
          ),
        ),
        gapH16,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'After approval, you can',
              style: Get.textTheme.bodyMedium,
            ),
            PrimaryTextButton(
              defaultTextStyle: false,
              style: Get.textTheme.bodyMedium?.copyWith(
                decoration: TextDecoration.underline,
              ),
              buttonLabel: 'Log in',
              onPressed: () => Get.offAll(const SignInScreen()),
            ),
          ],
        ),
      ],
    ))));
  }
}
