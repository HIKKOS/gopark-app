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
  final double costoActual;

  TarifaLoaded(CajonResponse tarifaData)
      : cajonId = tarifaData.cajonId,
        numeroCajon = tarifaData.numeroCajon,
        placavehiculo = tarifaData.placavehiculo,
        tarifaPorMinuto = tarifaData.tarifaPorMinuto,
        estado = tarifaData.estado,
        costoActual = tarifaData.costoActual;
  @override
  List<Object> get props => [
        cajonId,
        numeroCajon,
        placavehiculo,
        tarifaPorMinuto,
        estado,
        costoActual
      ];
}
