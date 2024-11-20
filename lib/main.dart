import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gopark/blocs/camera/camera_bloc.dart';
import 'package:gopark/blocs/cubit/tarifa_cubit.dart';
import 'package:gopark/config/routes.dart';

import 'package:gopark/utils/navigation_util.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CameraBloc()),
        BlocProvider(create: (_) => TarifaCubit()),
      ],
      child: MaterialApp(
          navigatorKey: Navigation.navigatorKey,
          initialRoute: AppRoutes.initialRoute,
          debugShowCheckedModeBanner: false,
          title: 'GoPark',
          routes: AppRoutes.routes),
    );
  }
}
