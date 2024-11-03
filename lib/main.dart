import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gopark/blocs/camera/camera_bloc.dart';
import 'package:gopark/presentation/views/camera_view.dart';
import 'package:gopark/presentation/views/home_view.dart';
import 'package:gopark/utils/navigation_util.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc(),
      child: MaterialApp(
        navigatorKey: Navigation.navigatorKey,
        initialRoute: "qr",
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routes: {
          'home': (context) => const HomeView(),
          "qr": (context) => const QRView(),
        },
      ),
    );
  }
}
