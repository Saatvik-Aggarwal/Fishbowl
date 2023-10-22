import 'package:fishbowl/obj/company.dart';
import 'package:fishbowl/obj/user.dart';
import 'package:flutter/cupertino.dart';

class GlobalState {
  static final GlobalState _instance = GlobalState._internal();
  factory GlobalState() => _instance;
  GlobalState._internal();

  FishbowlUser? user;
  // map of companyID to Company object
  Map<String, Company> companies = {};

  ValueNotifier<bool> popNavigator = ValueNotifier(false);
}
