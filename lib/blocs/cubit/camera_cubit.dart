import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gopark/config/const.dart';
import 'package:meta/meta.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraInitial());
}
