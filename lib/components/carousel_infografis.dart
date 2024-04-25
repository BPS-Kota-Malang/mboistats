import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:saf/saf.dart';

class CarouselInfografis extends StatefulWidget {
  const CarouselInfografis({Key? key}) : super(key: key);

  @override
  _CarouselInfografisState createState() => _CarouselInfografisState();
}

class _CarouselInfografisState extends State<CarouselInfografis> {
  late Saf saf;
  List<Map<String, dynamic>> dataInfografis = [];
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://webapi.bps.go.id/v1/api/list/domain/3573/model/infographic/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final infographic =
            (data['data'][1] as List).cast<Map<String, dynamic>>();
        setState(() {
          dataInfografis = infographic;
        });
      } else {
        throw Exception('Gagal mendapatkan data.');
      }
    } catch (error) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return dataInfografis.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 24.0,
                  bottom: 16.0,
                ),
                child: Text(
                  'INFOGRAFIS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 450,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 3 / 4,
                ),
                items: dataInfografis.map((item) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        imageUrl = item['img'] ?? '';
                      });

                      openDownloadConfirmation(context, imageUrl, item['title']);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        item['img'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
  }

  void openDownloadConfirmation(BuildContext context, String imageUrl, String imageTitle) async {
    try {
      bool confirmDownload = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Konfirmasi Unduh"),
            content: const Text("Apakah Anda ingin mengunduh berkas infografis ini?"),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, false);
                  await downloadAndShowConfirmation(context, imageUrl, imageTitle);
                },
                child: const Text("Ya"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text("Tidak"),
              ),
            ],
          );
        },
      );

      if (confirmDownload == true) {
        downloadAndShowConfirmation(context, imageUrl, imageTitle);
      }
    } catch (error) {

    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      var permissionStatus = await Permission.storage.status;

      if (permissionStatus.isDenied) {
        await Permission.storage.request();
        await saf.getDirectoryPermission(isDynamic: true);
        return permissionStatus.isGranted;
      }
      else {
        return permissionStatus.isGranted;
      }
    }
    return true;
  }

  Future<void> downloadAndShowConfirmation(BuildContext context, String pdfUrl, String fileName) async {
    // Check if the necessary permissions are granted
    if (await _checkPermission()) {
      try {
        Fluttertoast.showToast(
          msg: "Berkas infografis sedang diunduh.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        //Download a single file
        FileDownloader.downloadFile(
            url: pdfUrl,
            name: fileName,
            downloadDestination: DownloadDestinations.publicDownloads,
            onProgress: (fileName, double progress) {

            },
            onDownloadCompleted: (String path) {
              //Renaming File Extension
              path = path.replaceAll("%20", " ");
              path = path.replaceAll("%2C", "");
              String downloadedFileName = path.split('/').last;

              Fluttertoast.showToast(
                msg: 'Infografis "$downloadedFileName" telah disimpan dalam Folder Download.',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            onDownloadError: (String error) {
              Navigator.pop(context); // Close the download dialog
              Fluttertoast.showToast(
                msg: "Gagal mengunduh berkas.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            });
      } catch (error) {
        Navigator.pop(context); // Close the download dialog
        Fluttertoast.showToast(
          msg: "Terjadi kesalahan saat mengunduh. $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
    else {
      // Display a message indicating that the application is not authorized
      Fluttertoast.showToast(
        msg: "Aplikasi belum diizinkan untuk mengakses penyimpanan.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
