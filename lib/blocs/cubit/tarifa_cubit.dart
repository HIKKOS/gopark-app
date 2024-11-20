import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gopark/data/data_sources/http/auth/cajon_info.dart';
import 'package:gopark/data/models/cajon_response.dart';

part 'tarifa_state.dart';

class TarifaCubit extends Cubit<TarifaState> {
  TarifaCubit() : super(TarifaInitial());

  Future<void> getTarifa(int cajonid) async {
    emit(TarifaLoading());
    try {
      final data = await CajonInfoHttp().getInfo(cajonid);
      emit(TarifaLoaded(data));
    } catch (e) {
      emit(TarifaError());
    }
  }

  Future<void> unlink() async {
    emit(TarifaInitial());
  }
}
