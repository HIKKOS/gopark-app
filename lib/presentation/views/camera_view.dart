import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gopark/blocs/camera/camera_bloc.dart';
import 'package:gopark/blocs/cubit/tarifa_cubit.dart';

import 'package:gopark/config/themes/app_colors.dart';
import 'package:gopark/config/themes/app_themes.dart';
import 'package:gopark/presentation/widgets/banner_title.dart';
import 'package:gopark/utils/dialog_util.dart';

import 'package:gopark/utils/logger.dart';
import 'package:gopark/utils/navigation_util.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

//"3c5gvVGqeJDKZmwamcemh3fG1/30/10"
class QRView extends StatefulWidget {
  const QRView({super.key});

  @override
  State<QRView> createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear código QR')),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          height: 350,
          child: BlocBuilder<CameraBloc, CameraState>(
            builder: (_, CameraState state) {
              if (state.hasCameraPermissions) {
                return const _CameraGrantedView();
              }
              return _CameraDeniedView();
            },
          ),
        ),
        const BannerTitle.center('Buscando código QR'),
        const Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FluentIcons.qr_code_24_regular,
              size: 150,
              color: LightColors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text('Coloca el código Qr enfrente la cámara',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: LightColors.grey)),
            )
          ],
        ))
      ]),
    );
  }
}

class _CameraDeniedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(FluentIcons.camera_24_regular,
            size: 90, color: LightColors.grey),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('No se ha otorgado permiso para la cámara',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: LightColors.grey)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: LightColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius)),
            ),
            onPressed: () {
              BlocProvider.of<CameraBloc>(context).askCameraAccess();
            },
            child:
                const Text('Conceder acceso', style: TextStyle(fontSize: 16)),
          ),
        )
      ],
    );
  }
}

class _CameraGrantedView extends StatefulWidget {
  const _CameraGrantedView();

  @override
  State<_CameraGrantedView> createState() => _CameraGrantedViewState();
}

class _CameraGrantedViewState extends State<_CameraGrantedView> {
  Barcode? _code;
  String? _codeString;
  late final _cubit = BlocProvider.of<TarifaCubit>(context);
  late final MobileScannerController _controller;

  @override
  void initState() {
    super.initState();
    _codeString = null;
    _code = null;

    _controller = MobileScannerController(
        autoStart: true, detectionSpeed: DetectionSpeed.normal);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void showConfirm() async {
    try {
      _cubit.getTarifa(int.parse(_codeString!));
      Navigation.pushNamedAndRemoveUntil(routeName: "home");
    } on Exception catch (e) {
      Loggerify.error('QRView  showConfirm: $e');
      Dialogs.showAlert(
          title: 'Error',
          description: 'No se pudo obtener la información del cajón',
          acceptText: 'Reintentar',
          onAcceptPressed: () async {
            _controller.start();
            setState(() {});
          });
    }

    /*    _timeManagerBloc.add(const TimeManagerEvent.start()); */
    /*  Dialogs.showMorph(
        onCancelPressed: (_) {
          _controller.start();
          setState(() {});
        },
        title: '¡Codigo encontrado!',
        description: '¿Deseas agregar los puntos?',
        loadingTitle: 'Agregando puntos...',
        onAcceptPressed: _onAcceptPressed); */
  }

/*   Future _onAcceptPressed(_) async {
    Loggerify.info('QRView  _onAcceptPressed: $_codeString');
    _controller.start();
    setState(() {});
  }
 */
  Future<void> showNoValid() async {
    await Dialogs.showAlert(
        title: 'Codigo no valido',
        acceptText: 'Reintentar',
        description: 'El código escaneado no es valido',
        onAcceptPressed: () async {
          Navigation.pop(true);
        });
  }

  void onDetected(capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    _code = barcodes[0];
    if (_code == null) return;
    _codeString = _code!.rawValue;

    bool isValid = int.tryParse(_codeString!) != null;
    Loggerify.info('QRView  isValid: $isValid string: $_codeString');
    _controller.stop();
    if (!isValid) {
      await showNoValid();
      _controller.start();
      return;
    }
    _codeString = _code!.rawValue;
    setState(() {});

    showConfirm();

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      MobileScanner(
          controller: _controller, fit: BoxFit.cover, onDetect: onDetected),
      CustomPaint(
        size: const Size(double.infinity, 350),
        painter: DarkLayer(),
      )
    ]);
  }
}

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class DarkLayer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double gap = 20;
    Paint paint0 = Paint()
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;
    paint0.color = Colors.black45;
    Path path1 = Path();
    path1.moveTo(0, 0);
    path1.lineTo(0, size.height);
    path1.lineTo(size.width, size.height);
    path1.lineTo(size.width, 0);
    path1.lineTo(0, 0);
    // path1.close();
    path1.moveTo(size.width * gap / 100, size.height * gap / 100);
    path1.lineTo(size.width * (100 - gap) / 100, size.height * gap / 100);
    path1.lineTo(
        size.width * (100 - gap) / 100, size.height * (100 - gap) / 100);
    path1.lineTo(size.width * gap / 100, size.height * (100 - gap) / 100);
    // path1.lineTo(size.height * 0.2, size.height * 0.2);
    path1.close();
    canvas.drawPath(path1, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
