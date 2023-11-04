import 'package:mboistat/models/button.dart';

//ini dibangun menggunakan contruktor
List<MboistatButton> mboistatButton = [
  MboistatButton(
      button: 'berita', title: 'Berita Resmi Statistik', route: '/berita'),
  MboistatButton(button: 'publikasi', title: 'Publikasi', route: '/publikasi'),
  MboistatButton(
      button: 'infografis', title: 'Infografis', route: '/infografis'),
  MboistatButton(button: 'tentang', title: 'Tentang Kami', route: '/tentang'),
  MboistatButton(button: 'lainnya', title: 'Lainnya', route: '/more'),
];
