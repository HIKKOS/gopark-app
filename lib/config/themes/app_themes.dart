import 'package:flutter/material.dart';
import 'package:gopark/config/themes/app_colors.dart';

class AppTheme {
  static const double borderRadius = 10.0;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: LightColors.primary,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      backgroundColor: LightColors.secondary,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      buttonColor: LightColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      color: Colors.transparent,
      surfaceTintColor: Colors.white,
      elevation: 10,
      shadowColor: Colors.black,
    ),
    dialogBackgroundColor: Colors.white,
    dialogTheme: DialogTheme(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black54,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius / 2),
      ),
    ),
    dividerColor: LightColors.grey,
    dividerTheme: const DividerThemeData(
      color: LightColors.grey,
      thickness: 1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
        elevation: WidgetStateProperty.all<double>(5),
        shadowColor: const WidgetStatePropertyAll<Color>(Colors.black54),
        overlayColor:
            WidgetStateProperty.all<Color>(LightColors.primary.withGreen(110)),
        surfaceTintColor: WidgetStateProperty.all<Color>(LightColors.primary),
        foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius / 2),
          ),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(color: Colors.white)),
        backgroundColor: WidgetStateProperty.all<Color>(LightColors.primary),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: LightColors.primary,
      foregroundColor: Colors.white,
      splashColor: LightColors.primaryObscure,
      elevation: 5,
      focusColor: LightColors.primaryObscure,
      hoverColor: LightColors.primaryObscure,
      highlightElevation: 10,
      hoverElevation: 10,
      focusElevation: 10,
    ),
    highlightColor: LightColors.primaryObscure,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: LightColors.secondary),
      ),
      prefixIconColor: LightColors.grey,
      suffixIconColor: LightColors.primary,
      fillColor: Colors.white,
      filled: true,
      iconColor: LightColors.primary,
      contentPadding: const EdgeInsets.all(20),
      floatingLabelStyle: const TextStyle(color: LightColors.primary),

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: LightColors.primary, width: 2)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: LightColors.grey, width: 2)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: LightColors.grey, width: 2)),
      // prefixIcon: Icon( Icons.verified_user_outlined ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
      indicatorColor: LightColors.primary,
      surfaceTintColor: LightColors.primary,
      indicatorShape: InputBorder.none,
      labelTextStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(color: Colors.white, fontSize: 16)),
    ),
    indicatorColor: LightColors.primary,
    snackBarTheme: const SnackBarThemeData(
      /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius / 2))), */
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: LightColors.secondary,
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    splashColor: LightColors.primaryObscure,
    scaffoldBackgroundColor: LightColors.background,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: LightColors.primary,
    ),
    switchTheme: SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.all<Color>(LightColors.primary),
      thumbColor: WidgetStateProperty.all<Color>(LightColors.primary),
      trackColor:
          WidgetStateProperty.all<Color>(LightColors.primary.withAlpha(50)),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
      surfaceTintColor: WidgetStateProperty.all<Color>(LightColors.primary),
    )),
  );

  static final ThemeData darkTheme =
      ThemeData.dark().copyWith(primaryColor: LightColors.primary);
}
