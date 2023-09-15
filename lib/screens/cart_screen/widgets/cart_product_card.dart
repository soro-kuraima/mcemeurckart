import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/constants/index.dart';

import 'quantity_widget.dart';

class CartProductCard extends StatelessWidget {
  final dynamic product;
  final int quantity;
  final void Function()? increment;
  final void Function()? decrement;
  const CartProductCard(
      {Key? key,
      required this.product,
      required this.quantity,
      this.increment,
      this.decrement})
      : super(key: key);

  // final CartItemModel cartItemModel;

  // final CartController cartController = Get.find();
  // final ProductDataController productDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: .3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: AppColors.red400,
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
          child: Row(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: product['imageUrl'],
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
                      product['title'],
                      style: Get.textTheme.displayMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    gapH8,
                    QuantityWidget(
                      quantity: quantity,
                      increment: increment,
                      decrement: decrement,
                    ),
                  ],
                ),
              ),
              gapW16,
              Text(
                '₹${product['price']}',
                style: Get.textTheme.bodyMedium?.copyWith(
                  fontWeight: Fonts.interMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
