import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _prefs;
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences? get instance => _prefs;

  static set tiempoInicio(String? value) {
    _prefs?.setString('hora_inicio', value!);
  }

  static String? get tiempoInicio => _prefs?.getString('hora_inicio');

  static Future<void> limpiarPreferencias() async {
    await _prefs?.clear();
  }
}
