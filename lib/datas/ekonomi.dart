import 'package:mboistat/models/ekonomi.dart';

List<Ekonomi> ekonomi = [
  Ekonomi('laju_pertumbuhan.png', 'Laju Pertumbuhan Ekonomi',
      'Perubahan produksi barang dan jasa',
      route: '/LajuPertumbuhan'),
  Ekonomi('pdrb.png', 'PDRB Menurut Lapangan Usaha', 'PDRB atas dasar harga',
      route: '/PDRB'),
  Ekonomi('inflasi.png', 'Inflasi Tahun Kalender',
      'Presentase kenaikan harga produk',
      route: '/InflasiTahunKalender'),
  Ekonomi('inflasi_bulanan.png', 'Inflasi Bulanan',
      'Presentase kenaikan harga produk bulanan',
      route: '/InflasiBulanan'),
];
