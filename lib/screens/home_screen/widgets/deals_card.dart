import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mcemeurckart/constants/index.dart';
import 'favorite_button_widget.dart';

class DealsCard extends StatelessWidget {
  const DealsCard({
    super.key,
    this.width,
    this.height,
    this.onLikeTap,
    this.onCardTap,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  final double? width;
  final double? height;
  final String title;
  final int price;
  final String imageUrl;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCardTap;

  @override
  Widget build(BuildContext context) {
    log(onLikeTap.toString());
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.p10),
            ),
          ),
          color: AppColors.neutral100,
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(Sizes.p10),
            ),
            onTap: onCardTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.p10),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Sizes.p12,
                  Sizes.p28,
                  Sizes.p12,
                  Sizes.p12,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: Sizes.p8,
                          bottom: Sizes.p8,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          height: Sizes.deviceHeight * .3 / 2,
                          width: Sizes.deviceWidth * .3,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                          placeholder: (_, url) => Center(
                            child: CircularProgressIndicator.adaptive(
                              valueColor: AlwaysStoppedAnimation(
                                AppColors.neutral800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapH4,
                        SizedBox(
                          width: Sizes.deviceWidth * .3,
                          child: Text(
                            title,
                            style: Get.textTheme.displayMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        gapH8,
                        Row(
                          children: [
                            Text(
                              '₹$price',
                              style: Get.textTheme.bodyMedium?.copyWith(
                                color: AppColors.neutral600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: Sizes.p8),
          child: FavoriteButton(
            onPressed: onLikeTap,
          ),
        ),
      ],
    );
  }
}
