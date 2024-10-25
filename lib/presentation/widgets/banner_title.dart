import 'package:flutter/material.dart';
import 'package:gopark/config/themes/app_colors.dart';

class BannerTitle extends StatelessWidget {
  const BannerTitle(
    this.title, {
    super.key,
  }) : center = false;
  const BannerTitle.center(
    this.title, {
    super.key,
  }) : center = true;
  final String title;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LightColors.secondary,
      width: double.infinity,
      height: 50,
      child: Center(
        child: SizedBox(
          width: center ? null : MediaQuery.of(context).size.width,
          child: Padding(
            padding:
                center ? EdgeInsets.zero : const EdgeInsets.only(left: 12.0),
            child: Text(title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
