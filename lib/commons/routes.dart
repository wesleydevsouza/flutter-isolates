// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:isolates_chart/screens/Chart.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/intro':
        return MaterialPageRoute(
          builder: (context) => IsolatesChart(),
        );

      default:
        return MaterialPageRoute(builder: (context) => IsolatesChart());
    }
  }
}
