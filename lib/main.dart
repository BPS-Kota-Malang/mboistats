import 'package:flutter/material.dart';
import 'package:mboistat/route-manager.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/splash',
    routes: RouteManager.routes,
  ));
}
