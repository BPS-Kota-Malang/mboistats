import 'package:flutter/material.dart';
import 'package:mboistat/pages/berita-pages.dart';
import 'package:mboistat/pages/contact.dart';
import 'package:mboistat/pages/ekonomi/ekonomi-pages.dart';
import 'package:mboistat/pages/faq.dart';
import 'package:mboistat/pages/home_page.dart';
import 'package:mboistat/pages/infografis-pages.dart';
import 'package:mboistat/pages/kemiskinan-pages.dart';
import 'package:mboistat/pages/kemiskinan.dart';
import 'package:mboistat/pages/kependudukan-pages.dart';
import 'package:mboistat/pages/kesejahteraan-pages.dart';
import 'package:mboistat/pages/ketenagakerjaan-pages.dart';
import 'package:mboistat/pages/more-pages.dart';
import 'package:mboistat/pages/pertanian-pages.dart';
import 'package:mboistat/pages/publikasi.dart';
import 'package:mboistat/pages/tentang-pages.dart';
import 'package:mboistat/splash-screen.dart';
import 'package:mboistat/pages/IPM/index-pembangunan-manusia.dart';
import 'package:mboistat/pages/IPM/usia-harapan-hidup.dart';
import 'package:mboistat/pages/IPM/ipm-pages.dart';
import 'package:mboistat/pages/IPM/daya-beli.dart';
import 'package:mboistat/pages/IPM/rata-lama-sekolah.dart';
import 'package:mboistat/pages/IPM/harapan-lama-sekolah.dart';
import 'package:mboistat/pages/kependudukan/kependudukan-menurut-JK.dart';
import 'package:mboistat/pages/kependudukan/kependudukan-menurut-kecamatan.dart';
import 'package:mboistat/pages/kependudukan/penduduk-blimbing.dart';
import 'package:mboistat/pages/kependudukan/penduduk-kedungkandang.dart';
import 'package:mboistat/pages/kependudukan/penduduk-klojen.dart';
import 'package:mboistat/pages/kependudukan/penduduk-sukun.dart';
import 'package:mboistat/pages/kependudukan/penduduk-blimbing.dart';
import 'package:mboistat/pages/kependudukan/penduduk-lowokmaru.dart';
import 'package:mboistat/pages/ekonomi/ekonomi-pages.dart';
import 'package:mboistat/pages/ekonomi/inflasi-bulanan.dart';
import 'package:mboistat/pages/ekonomi/inflasi-tahunan.dart';
import 'package:mboistat/pages/ekonomi/laju-pertumbuhan.dart';
import 'package:mboistat/pages/ekonomi/pdrb-ekonomi.dart';

class RouteManager {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/splash': (context) => SplashScreen(),
    '/main': (context) => HomePage(),
    '/berita': (context) => BeritaPages(),
    '/infografis': (context) => InfografisPages(),
    '/tentang': (context) => TentangPages(),
    '/publikasi': (context) => PublikasiPages(),
    '/contact': (context) => Contact(),
    '/faq': (context) => FAQ(),
    '/kependudukan': (context) => KependudukanPages(),
    '/kemiskinan': (context) => KemiskinanPages(),
    '/ekonomi': (context) => EkonomiPages(),
    '/ipm': (context) => IPMPages(),
    '/kesejahteraan': (context) => KesejahteraanPages(),
    '/ketenagakerjaan': (context) => KetenagakerjaanPages(),
    '/pertanian': (context) => PertanianPages(),
    '/more': (context) => MorePages(),

    //IPM
    '/PendudukBekerja': (context) => IndexPembangunanManusiaPage(),
    '/UsiaHarapanHidup': (context) => UsiaHarapanHidupPage(),
    '/HarapanLamaSekolah': (context) => HarapanLamaSekolahPage(),
    '/RataRataLamaSekolah': (context) => RataRataLamaSekolahPage(),
    '/DayaBeli': (context) => DayaBeliPage(),

    //Kependudukan
    '/PendudukJK': (context) => KependudukanMenurutJKPage(),
    '/PendudukKec': (context) => KependudukanMenurutKecamatanPage(),
    '/PKedungkandang': (context) => PendudukKedungkandangPage(),
    '/PSukun': (context) => PendudukSukunPage(),
    '/PKlojen': (context) => PendudukKlojenPage(),
    '/PBlimbing': (context) => PendudukBlimbingPage(),
    '/PLowokmaru': (context) => PendudukLowokmaruPage(),


    //Ekonomi
    '/LajuPertumbuhan': (context) => LajuPertumbuhan(),
    '/PDRB': (context) => PDRB(),
    '/InflasiTahunKalender': (context) => InflasiTahunanPage(),
    '/InflasiBulanan': (context) => InflasiBulananPage(),
    

  



  };
}


