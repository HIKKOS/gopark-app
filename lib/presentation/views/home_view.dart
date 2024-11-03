import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gopark/config/themes/app_colors.dart';
import 'package:gopark/config/themes/app_themes.dart';
import 'package:gopark/presentation/widgets/banner_title.dart';
import 'package:gopark/presentation/widgets/shadow_container.dart';
import 'package:gopark/utils/dialog_util.dart';
import 'package:gopark/utils/navigation_util.dart';

const info = {
  'cajon': 'A12',
  'tiempo': '65 minutos',
  'placa': 'ABC-123',
};

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.primary,
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            const _TarifaHero(
              costoTarifa: 12.0,
              totalPagar: 16.5,
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
                      subtitle: Text(info['cajon']!),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Divider(),
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer),
                      title: const Text('Tiempo transcurrido'),
                      subtitle: Text(info['tiempo']!),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Divider(),
                    ),
                    ListTile(
                      leading: const Icon(Icons.abc_outlined),
                      title: const Text('Placa'),
                      subtitle: Text(info['placa']!),
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
                  Dialogs.showMorph(
                      title: "Desvincular cajón",
                      description: "¿Estás seguro de desvincular el cajón?",
                      loadingTitle: "loadingTitle",
                      loadingDescription: "loadingDescription",
                      onAcceptPressed: (_) async {
                        print('Desvincular cajón');
                        await Navigation.pushNamedAndRemoveUntil(
                            routeName: "qr");
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.borderRadius)),
                ),
                child: const Text('Desvincular cajón',
                    style: TextStyle(fontSize: 18)),
              )),
        )
      ]),
    );
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
                    text: '\$ ${costoTarifa.toStringAsFixed(2)}',
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
