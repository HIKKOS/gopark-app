import 'package:flutter/widgets.dart';
import 'package:gopark/presentation/views/camera_view.dart';
import 'package:gopark/presentation/views/home_view.dart';

class AppRoutes {
  static const String home = 'home';
  static const String qr = 'qr';
  static String initialRoute = qr;
  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeView(),
    qr: (context) => const QRView(),
  };
}
