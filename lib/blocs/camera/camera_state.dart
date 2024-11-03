part of 'camera_bloc.dart';

class CameraState extends Equatable {
  const CameraState({this.hasCameraPermissions = false});

  final bool hasCameraPermissions;

  @override
  List<Object?> get props => [hasCameraPermissions];
  copyWith({
    bool? hasCameraPermissions,
  }) =>
      CameraState(
        hasCameraPermissions: hasCameraPermissions ?? this.hasCameraPermissions,
      );
}
