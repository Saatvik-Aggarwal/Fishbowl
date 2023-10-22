import 'package:fishbowl/obj/user.dart';

class GlobalState {
  static final GlobalState _instance = GlobalState._internal();
  factory GlobalState() => _instance;
  GlobalState._internal();

  FishbowlUser? user;
}
