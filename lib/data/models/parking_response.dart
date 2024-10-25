/* seccion
numero
id */

import 'package:gopark/utils/preferences.dart';

class ParkingResponse {
  final String seccion;
  final String numero;
  final String tarifaMinuto;

  final String id;

  ParkingResponse(
      {required this.seccion,
      required this.tarifaMinuto,
      required this.numero,
      required this.id});

  factory ParkingResponse.fromJson(Map<String, dynamic> json) {
    return ParkingResponse(
      seccion: json['seccion'],
      numero: json['numero'],
      tarifaMinuto: json['tarifa_minuto'],
      id: json['id'],
    );
  }
  double get tarifaPagar {
    final dateSting = Preferences.tiempoInicio;
    final DateTime horaInicio =
        dateSting == null ? DateTime.now() : DateTime.parse(dateSting);
    final DateTime horaFin = DateTime.now();
    final int diff = horaFin.difference(horaInicio).inMinutes;
    return diff * double.parse(tarifaMinuto);
  }
}
