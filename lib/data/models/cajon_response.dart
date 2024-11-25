import 'dart:convert';

CajonResponse postFromJson(String str) =>
    CajonResponse.fromJson(json.decode(str));

String postToJson(CajonResponse data) => json.encode(data.toJson());

class CajonResponse {
  final int cajonId;
  final String numeroCajon;
  final String placavehiculo;
  final DateTime horaOcupado;
  final double tarifaPorMinuto;
  final String estado;
  final double costoActual;

  CajonResponse({
    required this.cajonId,
    required this.numeroCajon,
    required this.placavehiculo,
    required this.horaOcupado,
    required this.tarifaPorMinuto,
    required this.estado,
    required this.costoActual,
  });

  CajonResponse copyWith({
    int? cajonId,
    String? numeroCajon,
    String? placavehiculo,
    DateTime? horaOcupado,
    double? tarifaPorMinuto,
    String? estado,
    double? costoActual,
  }) =>
      CajonResponse(
        cajonId: cajonId ?? this.cajonId,
        numeroCajon: numeroCajon ?? this.numeroCajon,
        placavehiculo: placavehiculo ?? this.placavehiculo,
        horaOcupado: horaOcupado ?? this.horaOcupado,
        tarifaPorMinuto: tarifaPorMinuto ?? this.tarifaPorMinuto,
        estado: estado ?? this.estado,
        costoActual: costoActual ?? this.costoActual,
      );

  factory CajonResponse.fromJson(Map<String, dynamic> json) => CajonResponse(
        cajonId: json["cajonId"],
        numeroCajon: json["numeroCajon"],
        placavehiculo: json["placavehiculo"],
        horaOcupado: DateTime.parse(json["horaOcupado"]),
        tarifaPorMinuto: json["tarifaPorMinuto"]?.toDouble(),
        estado: json["estado"],
        costoActual: json["costoActual"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "cajonId": cajonId,
        "numeroCajon": numeroCajon,
        "placavehiculo": placavehiculo,
        "horaOcupado": horaOcupado.toIso8601String(),
        "tarifaPorMinuto": tarifaPorMinuto,
        "estado": estado,
        "costoActual": costoActual,
      };
  String getTiempoTranscurrido() {
    final now = DateTime.now();
    final occupiedTime = now.difference(horaOcupado);
    return occupiedTime.inHours.toString();
  }
}
