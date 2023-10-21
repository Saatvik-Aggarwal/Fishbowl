import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GlobalState {
  static final GlobalState _instance = GlobalState._internal();
  factory GlobalState() => _instance;
  GlobalState._internal();
}
