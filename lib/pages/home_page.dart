import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mboistat/components/buttonSection.dart';
import 'package:mboistat/components/carousel-infografis.dart';
import 'package:mboistat/components/carousel-publikasi.dart';
import 'package:mboistat/components/footer.dart';
import 'package:mboistat/components/menus.dart';
import 'package:mboistat/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
            'Konfirmasi Keluar',
            style: TextStyle(color: Colors.blue), // Warna teks biru
          ),
          content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
            actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue), // Warna border biru
              ),
              child: Text(
                'Tidak',
                style: TextStyle(color: Colors.blue), // Warna teks biru
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Close the entire app when 'Ya' is selected
                SystemNavigator.pop(); // Use this to exit the app
              },
              child: Text('Ya'),
            ),
          ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
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
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yuk lebih dekat dengan BPS Kota Malang',
                      style: bold16.copyWith(color: dark1),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Mau cari data apa ???',
                      style: regular14.copyWith(color: dark2),
                    ),
                  ],
                ),
              ),
              Menus(),
              ButtonSection(),
              CarouselPublikasi(),
              CarouselInfografis(),
            ],
          ),
        ),
        bottomNavigationBar: Footer(),
      ),
    );
  }
}
