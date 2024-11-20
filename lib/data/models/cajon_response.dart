class CajonResponse {
  int cajonId;
  String numeroCajon;
  String placavehiculo;
  double tarifaPorMinuto;
  String estado;
  double costoActual;

  CajonResponse({
    required this.cajonId,
    required this.numeroCajon,
    required this.placavehiculo,
    required this.tarifaPorMinuto,
    required this.estado,
    required this.costoActual,
  });
  CajonResponse.fromJson(Map<String, dynamic> json)
      : cajonId = json['cajonId'],
        numeroCajon = json['numeroCajon'],
        placavehiculo = json['placavehiculo'],
        tarifaPorMinuto = json['tarifaPorMinuto'],
        estado = json['estado'],
        costoActual = json['costoActual'];
}
