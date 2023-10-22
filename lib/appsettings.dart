import 'dart:math';
import 'dart:ui';

import 'package:fishbowl/etc/hexcolor.dart';

class AppSettings {
  bool loggedIn;
  bool darkMode;

  AppSettings({this.loggedIn = true, this.darkMode = true});

  Color getBackgroundColor() {
    return HexColor("202630");
    // return HexColor("000000");
  }

  // off white
  Color getPrimaryColor() {
    return HexColor("F0F0F0");
  }

  // blue
  Color getSecondaryColor() {
    return HexColor("379AFE");
  }

  Color getTextOnPrimaryColor() {
    return HexColor("000000");
  }

  Color getTextOnSecondaryColor() {
    return HexColor("F0F0F0");
  }
}
