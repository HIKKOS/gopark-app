import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:permission_handler/permission_handler.dart' hide ServiceStatus;

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(const CameraState()) {
    on<CameraPermissionEvent>(_onCameraPermissionEvent);

    _init();
  }
  _onCameraPermissionEvent(
      CameraPermissionEvent event, Emitter<CameraState> emit) {
    emit(state.copyWith(
      hasCameraPermissions: event.hasCameraPermissions,
    ));
  }

  Future<void> _init() async {
    final gpsStatus = await _isPermissionGranted();
    add(CameraPermissionEvent(gpsStatus));
  }

  Future<void> askCameraAccess() async {
    try {
      final status = await Permission.camera.request();
      if (status.isGranted) {
        add(const CameraPermissionEvent(true));
        return;
      }
      add(const CameraPermissionEvent(false));
      openAppSettings();
    } on Exception catch (_) {
      openAppSettings();
    }
  }

  Future<bool> _isPermissionGranted() async {
    final permissionStatus = await Permission.camera.isGranted;
    return permissionStatus;
  }
}