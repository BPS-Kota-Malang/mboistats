import 'package:flutter/material.dart';
import 'package:mboistat/pages/berita-pages.dart';
import 'package:mboistat/pages/ekonomi-pages.dart';
import 'package:mboistat/pages/home_page.dart';
import 'package:mboistat/pages/kependudukan-pages.dart';
import 'package:mboistat/pages/kemiskinan-pages.dart';
import 'package:mboistat/pages/ipm-pages.dart';
import 'package:mboistat/pages/kesejahteraan-pages.dart';
import 'package:mboistat/pages/ketenagakerjaan-pages.dart';
import 'package:mboistat/pages/more-pages.dart';
import 'package:mboistat/pages/pertanian-pages.dart';
import 'package:mboistat/splash-screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/splash',
    routes: {
      '/kependudukan': (context) => KependudukanPages(),
      '/kemiskinan': (context) => KemiskinanPages(),
      '/ekonomi': (context) => EkonomiPages(),
      '/ipm': (context) => IPMPages(),
      '/kesejahteraan': (context) => KesejahteraanPages(),
      '/ketenagakerjaan': (context) => KetenagakerjaanPages(),
      '/pertanian': (context) => PertanianPages(),
      '/more': (context) => MorePages(),
      '/splash': (context) =>
          SplashScreen(), // Gunakan widget splash screen di sini
      '/main': (context) => HomePage(),
      '/berita': (context) => BeritaPages(),
    },
  ));
}
