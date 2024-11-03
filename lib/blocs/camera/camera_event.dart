part of 'camera_bloc.dart';

sealed class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class CameraPermissionEvent extends CameraEvent {
  final bool hasCameraPermissions;
  const CameraPermissionEvent(this.hasCameraPermissions);
}
