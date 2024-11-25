import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gopark/blocs/cubit/tarifa_cubit.dart';
import 'package:gopark/config/themes/app_colors.dart';
import 'package:gopark/config/themes/app_themes.dart';
import 'package:gopark/presentation/widgets/banner_title.dart';
import 'package:gopark/presentation/widgets/shadow_container.dart';
import 'package:gopark/utils/dialog_util.dart';
import 'package:gopark/utils/navigation_util.dart';
import 'package:gopark/utils/preferences.dart';

const info = {
  'cajon': 'A12',
  'tiempo': '65 minutos',
  'placa': 'ABC-123',
};
final DateTime? startedTime = DateTime.tryParse(Preferences.tiempoInicio ?? '');

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.primary,
      ),
      body: BlocBuilder<TarifaCubit, TarifaState>(
        builder: (_, state) {
          switch (state) {
            case TarifaLoading _:
              return const Center(child: CircularProgressIndicator());
            case TarifaError _:
              return const Center(child: Text('Error'));
            case TarifaLoaded _:
              return Body(
                tiempoOcupado: state.tiempoOcupado,
                cajonId: state.cajonId,
                numeroCajon: state.numeroCajon,
                placavehiculo: state.placavehiculo,
                tarifaPorMinuto: state.tarifaPorMinuto,
                estado: state.estado,
                costoActual: state.costoActual,
              );
            default:
              return const Center(child: Text('Error'));
          }
        },
      ) /* Body() */,
    );

    /*  */
  }
}

class Body extends StatelessWidget {
  final int cajonId;
  final String numeroCajon;
  final String placavehiculo;
  final String estado;
  final double tarifaPorMinuto;
  final double costoActual;
  final String tiempoOcupado;
  const Body({
    super.key,
    required this.cajonId,
    required this.numeroCajon,
    required this.placavehiculo,
    required this.tarifaPorMinuto,
    required this.estado,
    required this.costoActual,
    required this.tiempoOcupado,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TarifaCubit>(context);
    final size = MediaQuery.of(context).size;
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        children: [
          _TarifaHero(
            costoTarifa: tarifaPorMinuto,
            totalPagar: costoActual,
          ),
          const BannerTitle('Información'),
          const SizedBox(
            height: 20,
          ),
          ShadowContainer(
              width: size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(children: [
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Cajón'),
                    subtitle: Text(numeroCajon),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: const Text('Tiempo transcurrido'),
                    subtitle: RichText(
                      text: TextSpan(
                        text: tiempoOcupado,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        children: const [
                          TextSpan(
                            text: ' Horas',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.abc_outlined),
                    title: const Text('Placa'),
                    subtitle: Text(placavehiculo),
                  ),
                ]),
              )),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
            height: 50,
            width: size.width * 0.9,
            child: ElevatedButton(
              onPressed: () {
                Dialogs.showAlert(
                    title: "Desvincular cajón",
                    description: "¿Estás seguro de desvincular el cajón?",
                    acceptText: "Desvincular",
                    onAcceptPressed: () {
                      cubit.unlink();
                      Navigation.pop();
                      Navigation.pushReplacementNamed(routeName: "qr");
                    });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: LightColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
              ),
              child: const Text('Desvincular cajón',
                  style: TextStyle(fontSize: 18)),
            )),
      )
    ]);
  }
}

class _TarifaHero extends StatelessWidget {
  final double totalPagar;
  final double costoTarifa;
  const _TarifaHero({
    required this.costoTarifa,
    required this.totalPagar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: LightColors.primary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (totalPagar > 0)
            Positioned(
              top: 50,
              child: Text(
                '\$ ${totalPagar.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 48),
              ),
            ),
          Positioned(
              bottom: 5,
              right: 15,
              child: RichText(
                  text: TextSpan(
                text: 'con una tarifa de ',
                style: const TextStyle(color: Colors.white, fontSize: 16),
                children: [
                  TextSpan(
                    text: '\$ ${(costoTarifa * 60).toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  const TextSpan(
                    text: ' por hora',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              )))
        ],
      ),
    );
  }
}
