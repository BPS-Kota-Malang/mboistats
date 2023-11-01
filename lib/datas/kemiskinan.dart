import 'package:mboistat/models/kemiskinan.dart';

List<Kemiskinan> kemiskinan = [
  Kemiskinan(
      'kemiskinan_1.png', 'Tingkat Kemiskinan', 'Presentase penduduk miskin', route: '/TingkatKemiskinan'),
  Kemiskinan('kemiskinan_2.png', 'Indeks Kedalaman Kemiskinan',
      'Pengeluaran terhadap garis kemiskinan', route: '/IndeksKedalamanKemiskinan'),
  Kemiskinan('kemiskinan_3.png', 'Indeks Keparahan Kemiskinan',
      'Pengeluaran penduduk miskin', route: '/IndeksKeparahanKemiskinan'),
  Kemiskinan('kemiskinan_4.png', 'Garis Kemiskinan',
      'Jumlah rupiah kebutuhan pokok',route: '/GarisKemiskinan'),
];
