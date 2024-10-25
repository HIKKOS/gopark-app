import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';

class Loggerify {
  static final Logger _logger = Logger();
  static void error(String message) {
    _logger.e(message);
  }

  static void info(Object? message) {
    _logger.i(message);
  }

  static void debug(Object? message) {
    _logger.d(message);
  }

  static void warning(Object? message) {
    _logger.w(message);
  }
}
