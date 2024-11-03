part of 'camera_cubit.dart';

@immutable
sealed class CameraState extends Equatable {
  const CameraState();
}

final class CameraInitial extends CameraState {
  const CameraInitial({
    this.state = CameraPermission.unknown,
  });
  final CameraPermission state;

  @override
  List<Object?> get props => [state];
}
