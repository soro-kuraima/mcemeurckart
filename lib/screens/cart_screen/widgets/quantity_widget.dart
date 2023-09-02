import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcemeurckart/constants/index.dart';

class QuantityWidget extends StatelessWidget {
  final int quantity;
  final void Function()? increment;
  final void Function()? decrement;
  const QuantityWidget(
      {super.key, required this.quantity, this.increment, this.decrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p12,
        vertical: Sizes.p8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.p6,
        ),
        border: Border.all(
          color: AppColors.neutral200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuantityButton(
            icon: Icons.remove,
            onPressed: decrement ?? () {},
          ),
          VerticalDivider(
            thickness: 2,
            color: AppColors.neutral800,
          ),
          Text(
            quantity.toString(),
            style: Get.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          VerticalDivider(
            thickness: 2,
            color: AppColors.neutral800,
          ),
          _QuantityButton(
            icon: Icons.add,
            onPressed: increment ?? () {},
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Sizes.p6),
      onTap: onPressed,
      child: Ink(
        width: Sizes.p24,
        height: Sizes.p24,
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.color,
          color: AppColors.neutral200,
        ),
        child: Icon(
          icon,
          color: AppColors.neutral800,
        ),
      ),
    );
  }
}
