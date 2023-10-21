import 'dart:math';
import 'dart:ui';

import 'package:fishbowl/etc/hexcolor.dart';

class AppSettings {
  bool loggedIn;
  bool darkMode;

  AppSettings({required this.loggedIn, required this.darkMode});

  Color getBackgroundColor() {
    return HexColor("202630");
    // return HexColor("000000");
  }

  Color getPrimaryColor() {
    return HexColor("F0F0F0");
  }

  Color getSecondaryColor() {
    return HexColor("379AFE");
  }
}
