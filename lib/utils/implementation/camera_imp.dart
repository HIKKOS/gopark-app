import 'package:flutter/services.dart';
import 'package:gopark/utils/interfaces/i_camera.dart';
import 'package:image_picker/image_picker.dart';

class CameraImp implements ICameraUtil {
  @override
  Future<Uint8List?> takePhoto() async {
    Uint8List? bytes;
    final imagePicker = ImagePicker();
    final takenPhoto = await imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    if (takenPhoto != null) {
      bytes = await takenPhoto.readAsBytes();
    }
    return bytes;
  }
}
