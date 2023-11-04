import 'package:mboistat/models/ketenagakerjaan.dart';

List<Ketenagakerjaan> ketenagakerjaan = [
  Ketenagakerjaan('angkatan_kerja.png', 'Angkatan Kerja Menurut Pendidikan',
      'Penduduk bekerja sementara',
      route: '/AKMenurutPendidikan'),
  Ketenagakerjaan(
      'tingkat_partisipasi.png',
      'Tingkat Partisipasi Angkatan Kerja',
      'Presentase angkatan kerja pada usia kerja',
      route: '/PartisipasiAngkatanKerja'),
  Ketenagakerjaan('tingkat_pengangguran.png', 'Tingkat Pengangguran Terbuka',
      'Presentase pengangguran angkatan kerja',
      route: '/TingkatPengangguran'),
  Ketenagakerjaan('pengangguran.png', 'Pengangguran Menurut Pendidikan',
      'Penduduk tidak punya pekerjaan',
      route: '/PengangguranMenurutPendidikan'),
];
