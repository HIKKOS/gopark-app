part of 'tarifa_cubit.dart';

sealed class TarifaState extends Equatable {
  const TarifaState();

  @override
  List<Object> get props => [];
}

final class TarifaInitial extends TarifaState {}

final class TarifaLoading extends TarifaState {}

final class TarifaError extends TarifaState {}

final class TarifaLoaded extends TarifaState {
  final int cajonId;
  final String numeroCajon;
  final String placavehiculo;
  final double tarifaPorMinuto;
  final String estado;
  final String tiempoOcupado;
  final double costoActual;

  const TarifaLoaded({
    required this.cajonId,
    required this.numeroCajon,
    required this.placavehiculo,
    required this.tarifaPorMinuto,
    required this.estado,
    required this.tiempoOcupado,
    required this.costoActual,
  });

  TarifaLoaded copyWith({
    int? cajonId,
    String? numeroCajon,
    String? placavehiculo,
    double? tarifaPorMinuto,
    String? estado,
    double? costoActual,
    String? tiempoOcupado,
  }) =>
      TarifaLoaded(
        cajonId: cajonId ?? this.cajonId,
        numeroCajon: numeroCajon ?? this.numeroCajon,
        placavehiculo: placavehiculo ?? this.placavehiculo,
        tarifaPorMinuto: tarifaPorMinuto ?? this.tarifaPorMinuto,
        estado: estado ?? this.estado,
        costoActual: costoActual ?? this.costoActual,
        tiempoOcupado: tiempoOcupado ?? this.tiempoOcupado,
      );

  @override
  List<Object> get props => [
        cajonId,
        numeroCajon,
        placavehiculo,
        tarifaPorMinuto,
        estado,
        costoActual,
        tiempoOcupado
      ];
}
