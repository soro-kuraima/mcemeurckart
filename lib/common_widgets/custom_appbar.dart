import 'package:flutter/material.dart';
import 'package:mcemeurckart/constants/index.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.onPressedTrailing, this.trailingIcon});

  final void Function()? onPressedTrailing;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blue100,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: trailingIcon ?? const Icon(Icons.sunny),
        ),
      ],
    );
  }
}
