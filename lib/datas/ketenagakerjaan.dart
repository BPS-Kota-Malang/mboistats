import 'package:mboistat/models/ketenagakerjaan.dart';

List<Ketenagakerjaan> ketenagakerjaan = [
  Ketenagakerjaan('angkatan_kerja.png', 'Angkatan Kerja Menurut Pendidikan',
      route: '/AKMenurutPendidikan'),
  Ketenagakerjaan(
      'tingkat_partisipasi.png',
      'Tingkat Partisipasi Angkatan Kerja',
      route: '/PartisipasiAngkatanKerja'),
  Ketenagakerjaan('tingkat_pengangguran.png', 'Tingkat Pengangguran Terbuka',
      route: '/TingkatPengangguran'),
  Ketenagakerjaan('pengangguran.png', 'Pengangguran Menurut Pendidikan',
      route: '/PengangguranMenurutPendidikan'),
];
