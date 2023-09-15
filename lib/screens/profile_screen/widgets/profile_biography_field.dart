import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/common_widgets/index.dart';
import 'package:mcemeurckart/constants/index.dart';

import 'profile_picture.dart';

class ProfileBiography extends StatelessWidget {
  const ProfileBiography({
    super.key,
    required this.userName,
    required this.userBiography,
    required this.editFunction,
  });

  final String userName;
  final String userBiography;
  final VoidCallback editFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: Get.textTheme.displayLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              gapH8,
              Text(
                userBiography,
                style: Get.textTheme.titleLarge?.copyWith(
                  fontWeight: Fonts.interRegular,
                ),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
              gapH8,
              Align(
                alignment: Alignment.centerLeft,
                child: PrimaryOutlinedButton(
                  hasText: true,
                  title: 'Sign Out',
                  onPressed: editFunction,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              // bottom: AppSizes.p48,
              bottom: (userBiography.length < 20 && userName.length < 10)
                  ? Sizes.p28
                  : Sizes.p70,
            ),
            child: const ProfilePicture(),
          ),
        ),
      ],
    );
  }
}
