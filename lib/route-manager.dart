//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:mboistat/pages/berita-pages.dart';
import 'package:mboistat/pages/contact.dart';
import 'package:mboistat/pages/ekonomi/ekonomi-pages.dart';
import 'package:mboistat/pages/faq.dart';
import 'package:mboistat/pages/home_page.dart';
import 'package:mboistat/pages/infografis-pages.dart';
import 'package:mboistat/pages/kemiskinan/kemiskinan.dart';
import 'package:mboistat/pages/kependudukan/kependudukan-pages.dart';
import 'package:mboistat/pages/kesejahteraan/kesejahteraan-pages.dart';
import 'package:mboistat/pages/ketenagakerjaan/ketenagakerjaan-pages.dart';
import 'package:mboistat/pages/more-pages.dart';
import 'package:mboistat/pages/pertanian/pertanian-pages.dart';
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
import 'package:mboistat/pages/kependudukan/penduduk-lowokmaru.dart';
import 'package:mboistat/pages/ekonomi/inflasi-bulanan.dart';
import 'package:mboistat/pages/ekonomi/inflasi-tahunan.dart';
import 'package:mboistat/pages/ekonomi/laju-pertumbuhan.dart';
import 'package:mboistat/pages/ekonomi/pdrb-ekonomi.dart';
import 'package:mboistat/pages/kemiskinan/garis-kemiskinan.dart';
import 'package:mboistat/pages/kemiskinan/indeks-kedalaman-kemiskinan.dart';
import 'package:mboistat/pages/kemiskinan/indeks-keparahan-kemiskinan.dart';
import 'package:mboistat/pages/kemiskinan/tingkat-kemiskinan.dart';
import 'package:mboistat/pages/ketenagakerjaan/AK-Menurut-Pendidikan.dart';
import 'package:mboistat/pages/ketenagakerjaan/pengangguran-pendidikan.dart';
import 'package:mboistat/pages/ketenagakerjaan/persentase-pengangguran-AK.dart';
import 'package:mboistat/pages/ketenagakerjaan/tingkat-partisipasi-AK.dart';
import 'package:mboistat/pages/kesejahteraan/gini-rasio.dart';
import 'package:mboistat/pages/kesejahteraan/pengeluaran-ekonomi.dart';
import 'package:mboistat/pages/pertanian/luas-lahan.dart';
import 'package:mboistat/pages/pertanian/produksi-beras.dart';
import 'package:mboistat/pages/pertanian/produksi-padi.dart';
import 'package:mboistat/pages/pertanian/produktivitas-padi.dart';

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
    '/PLowokwaru': (context) => PendudukLowokwaruPage(),

    //Ekonomi
    '/LajuPertumbuhan': (context) => LajuPertumbuhan(),
    '/Ekonomi': (context) => EkonomiPages(),
    '/PDRB': (context) => PDRB(),
    '/InflasiTahunKalender': (context) => InflasiTahunanPage(),
    '/InflasiBulanan': (context) => InflasiBulananPage(),

    //Kemiskinan
    '/kemiskinan': (context) => KemiskinanPages(),
    '/TingkatKemiskinan': (context) => TingkatKemiskinanPage(),
    '/IndeksKedalamanKemiskinan': (context) => IndeksKedalamanKemiskinanPage(),
    '/IndeksKeparahanKemiskinan': (context) => IndeksKeparahanKemiskinan(),
    '/GarisKemiskinan': (context) => GarisKemiskinanPage(),

    //Ketenagakerjaan
    '/AKMenurutPendidikan': (context) => AngkatanKerjaMenurutPendidikanPage(),
    '/PartisipasiAngkatanKerja': (context) =>
        TingkatPartisipasiAngkatanKerjaPage(),
    '/TingkatPengangguran': (context) =>
        PersentasePengangguranMenurutPendidikanPage(),
    '/PengangguranMenurutPendidikan': (context) =>
        PengangguranMenurutPendidikanPage(),

    //Kesejahteraan
    '/GiniRasio': (context) => GiniRasioPage(),
    '/PengeluaranEkonomi': (context) => PengeluaranEkonomiPage(),

    //Pertanian
    '/LuasLahanPadi': (context) => LuasLahanPadiPage(),
    '/ProduksiPadi': (context) => ProduksiPadiPage(),
    '/ProduktivitasPadi': (context) => ProduktivitasPadiPage(),
    '/ProduksiBeras': (context) => ProduksiBerasPage(),
  };
}
