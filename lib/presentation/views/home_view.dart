import 'package:flutter/material.dart';
import 'package:gopark/config/themes/app_colors.dart';
import 'package:gopark/config/themes/app_themes.dart';
import 'package:gopark/presentation/widgets/banner_title.dart';
import 'package:gopark/presentation/widgets/shadow_container.dart';

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
            const _PuntosHero(),
            const BannerTitle('Información'),
            const SizedBox(
              height: 20,
            ),
            ShadowContainer(
                width: size.width * 0.9,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(children: [
                    ListTile(
                      title: Text('Cajón'),
                      subtitle: Text('A12'),
                    ),
                    ListTile(
                      title: Text('Tiempo transcurrido'),
                      subtitle: Text('65 minutos'),
                    ),
                    ListTile(
                      title: Text('Placa'),
                      subtitle: Text('ABC-123'),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: LightColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.borderRadius)),
                ),
                child: const Text('Desvincular cajón'),
              )),
        )
      ]),
    );
  }
}

class _PuntosHero extends StatelessWidget {
  const _PuntosHero();

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
            child: RichText(
              text: const TextSpan(
                text: '\$ 145.00',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 48),
                children: <TextSpan>[],
              ),
            ),
          ),
          const Positioned(
              bottom: 5,
              right: 15,
              child: Text('con una tarifa de \$ 10.00 por hora',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16)))
        ],
      ),
    );
  }
}
