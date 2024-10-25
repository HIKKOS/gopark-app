import 'dart:typed_data';

abstract interface class ICameraUtil {
  Future<Uint8List?> takePhoto();
}
