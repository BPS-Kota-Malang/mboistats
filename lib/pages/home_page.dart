import 'package:flutter/material.dart';
import 'package:mboistat/components/buttonSection.dart';
import 'package:mboistat/components/carousel-berita.dart';
import 'package:mboistat/components/carousel-infografis.dart';
import 'package:mboistat/components/carousel-publikasi.dart';
import 'package:mboistat/components/carousel-tentang.dart';
import 'package:mboistat/components/footer.dart';
import 'package:mboistat/components/menus.dart';
import 'package:mboistat/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 50,
        title: const Text(
          'MBOIStatS+',
          style: TextStyle(color: Colors.black),
        ),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/images/Mbois-stat Logo_Fix Putih.png',
                width: 40, height: 40),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0), // Tambahkan jarak 16 di semua sisi
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yuk lebih dekat dengan BPS Kota Malang',
                  style: bold16.copyWith(color: dark1),
                ),
                SizedBox(height: 8.0), // Tambahkan jarak antara kalimat
                Text(
                  'Mau cari data apa ???',
                  style: regular14.copyWith(color: dark2),
                ),
              ],
            ),
          ),
          Menus(),
          ButtonSection(),
          CarouselBerita(),
          CarouselPublikasi(),
          CarouselInfografis(),
          CarouselTentang(),
        ],
      )),
      bottomNavigationBar: Footer(),
    );
  }
}
