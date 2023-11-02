import 'package:mboistat/models/pertanian.dart';

List<Pertanian> pertanian = [
  Pertanian('pertanian_1.png', 'Produksi Padi', 'Hasil perkalian luas dan produktivitas',route:'/ProduksiPadi'),
  Pertanian('pertanian_2.png', 'Luas Lahan Padi',
      'Dihitung dengan metodologi KSA', route:'/LuasLahanPadi'),
  Pertanian('pertanian_3.png', 'Produktivitas Padi',
      'Hasil bagi antara produksi dan luas', route:'/ProduktivitasPadi'),
  Pertanian('pertanian_4.png', 'Produksi Beras',
      'Dihitung dengan angka konversi GKG', route:'/ProduksiBeras'),
];
