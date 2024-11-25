import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gopark/data/data_sources/http/auth/cajon_info.dart';

part 'tarifa_state.dart';

class TarifaCubit extends Cubit<TarifaState> {
  TarifaCubit() : super(TarifaInitial());
  late Timer timer;

  Future<void> getTarifa(int cajonid) async {
    emit(TarifaLoading());
    try {
      final data = await CajonInfoHttp().getInfo(cajonid);
      emit(TarifaLoaded(
        cajonId: data.cajonId,
        numeroCajon: data.numeroCajon,
        placavehiculo: data.placavehiculo,
        tarifaPorMinuto: data.tarifaPorMinuto,
        estado: data.estado,
        tiempoOcupado: data.getTiempoTranscurrido(),
        costoActual: data.costoActual,
      ));
      timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        updateTarifaEveryMinute();
      });
    } catch (e) {
      emit(TarifaError());
    }
  }

  updateTarifaEveryMinute() async {
    if (state is! TarifaLoaded) return;
    final loaded = state as TarifaLoaded;
    final newState = loaded.copyWith(
      costoActual: loaded.costoActual + loaded.tarifaPorMinuto,
    );
    emit(newState);
  }

  Future<void> unlink() async {
    emit(TarifaInitial());
  }
}
