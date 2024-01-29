import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mboistat/components/buttonSection.dart';
import 'package:mboistat/components/carousel-infografis.dart';
import 'package:mboistat/components/carousel-publikasi.dart';
import 'package:mboistat/components/footer.dart';
import 'package:mboistat/components/menus.dart';
import 'package:mboistat/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_settings/open_settings.dart';
import 'package:package_info/package_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _checkAndRequestStoragePermission();
  }

  Future<void> _checkAndRequestStoragePermission() async {
    if (await _isAndroid13OrAbove()) {
      await _requestManageExternalStoragePermission();
    } else {
      await _requestWriteExternalStoragePermission();
    }
  }

  Future<bool> _onWillPop(BuildContext context) async {
    // Memeriksa dan meminta izin WRITE_EXTERNAL_STORAGE atau MANAGE_EXTERNAL_STORAGE
    if (await _isAndroid13OrAbove()) {
      await _requestManageExternalStoragePermission();
    } else {
      await _requestWriteExternalStoragePermission();
    }

    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Konfirmasi Keluar',
              style: TextStyle(color: Colors.blue),
            ),
            content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                ),
                child: Text(
                  'Tidak',
                  style: TextStyle(color: Colors.blue),
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

  Future<bool> _isAndroid13OrAbove() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var buildNumber = int.tryParse(packageInfo.buildNumber) ?? 0;
    return buildNumber >= 13;
  }

  Future<void> _requestWriteExternalStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var result = await Permission.storage.request();
      if (result != PermissionStatus.granted) {
        // Izin tidak diberikan, berikan informasi atau ambil tindakan sesuai kebutuhan
        print('Izin penyimpanan tidak diberikan.');
      }
    }
  }

  Future<void> _requestManageExternalStoragePermission() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      var result = await Permission.manageExternalStorage.request();
      if (result != PermissionStatus.granted) {
        // Izin tidak diberikan, berikan informasi atau ambil tindakan sesuai kebutuhan
        print('Izin penyimpanan tidak diberikan.');
      }
    }
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
