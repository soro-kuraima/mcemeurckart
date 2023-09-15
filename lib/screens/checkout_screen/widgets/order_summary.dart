import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/constants/index.dart';

class OrderSummary extends StatelessWidget {
  final dynamic cartItem;

  const OrderSummary({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(cartItem.toString());
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Row(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: cartItem.product['imageUrl'],
                width: 80,
                height: 80,
                placeholder: (_, url) => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
            gapW16,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Index No: ${cartItem.product['index']}',
                    style: Get.textTheme.bodyMedium,
                  ),
                  Text(
                    cartItem.product['title'],
                    style: Get.textTheme.displayMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  gapH8,
                  Text(
                    'Quantity: ${cartItem.quantity}',
                    style: Get.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            gapW16,
            Text(
              'Price ₹ ${cartItem.product['price']} /-',
              style: Get.textTheme.bodyMedium?.copyWith(
                fontWeight: Fonts.interMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
