import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/constants/index.dart';
import 'favorite_button_widget.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
    this.width,
    this.height,
    this.cardColor,
    this.onPressed,
    this.onLikeTap,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  final double? width;
  final double? height;
  final Color? cardColor;
  final String title;
  final int price;
  final String imageUrl;
  final VoidCallback? onPressed;
  final VoidCallback? onLikeTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.p10),
            ),
          ),
          color: cardColor ?? AppColors.blue300,
          child: InkWell(
            highlightColor: AppColors.neutral300.withOpacity(.9),
            borderRadius: const BorderRadius.all(
              Radius.circular(Sizes.p10),
            ),
            onTap: onPressed,
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
                    gapH24,
                    CachedNetworkImage(
                      width: Sizes.deviceWidth * .5,
                      height: Sizes.deviceHeight * .4 / 2,
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (_, url) => Center(
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation(
                            AppColors.neutral800,
                          ),
                        ),
                      ),
                    ),
                    gapH12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Sizes.deviceWidth * .4,
                          child: Text(
                            title,
                            style: Get.textTheme.displayLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            // textAlign: TextAlign.center,
                          ),
                        ),
                        gapH4,
                        Text(
                          '₹$price',
                          style: Get.textTheme.bodyLarge?.copyWith(
                            fontWeight: Fonts.interRegular,
                          ),
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
        )
      ],
    );
  }
}
