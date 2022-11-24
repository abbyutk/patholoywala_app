import 'package:flutter/foundation.dart';

class Console {
  static void log(e,{bool p = false}) {
    if (kDebugMode && p) print(e);
  }
}
