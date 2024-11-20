part of 'camera_bloc.dart';

sealed class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class OnCameraPermissionEvent extends CameraEvent {
  final bool hasCameraPermissions;
  const OnCameraPermissionEvent(this.hasCameraPermissions);
}

class OnQrValidScannedCamera extends CameraEvent {
  final String uuid;
  const OnQrValidScannedCamera(this.uuid);
}
