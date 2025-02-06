import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void push(MaterialPageRoute route) {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.push(route);
    } else {
      print("Error: Navigator context is null. Cannot navigate.");
    }
  }

  static void pushAndRemoveUntil(MaterialPageRoute route) {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushAndRemoveUntil(route, (route) => false);
    } else {
      print("Error: Navigator context is null. Cannot navigate.");
    }
  }
}