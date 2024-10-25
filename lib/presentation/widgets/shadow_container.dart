import 'package:flutter/material.dart';
import 'package:gopark/config/themes/app_colors.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({super.key, this.child, this.width, this.height});
  final Widget? child;
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: LightColors.background,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
          ],
        ),
        child: child);
  }
}
