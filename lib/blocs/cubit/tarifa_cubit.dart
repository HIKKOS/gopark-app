import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gopark/data/data_sources/http/auth/cajon_info.dart';
import 'package:gopark/utils/logger.dart';

part 'tarifa_state.dart';

class TarifaCubit extends Cubit<TarifaState> {
  int id = -1;
  TarifaCubit() : super(TarifaInitial());
  late Timer timer;

  Future<void> getTarifa(int cajonid) async {
    emit(TarifaLoading());
    try {
      id = cajonid;
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
      Loggerify.error(e.toString());
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
    id = -1;
    emit(TarifaInitial());
  }

  Future<void> retry() async {
    getTarifa(id);
  }
}
