import 'package:flutter/material.dart';

import 'package:mcemeurckart/common_widgets/svg_asset.dart';
import 'package:mcemeurckart/constants/index.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    this.width,
    this.height,
    this.color,
    required this.onPressed,
  });

  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgAsset(
        assetPath: AppIcons.favoriteIcon,
        width: width ?? Sizes.p20,
        height: height ?? Sizes.p20,
        color: color ?? AppColors.neutral800,
      ),
    );
  }
}
