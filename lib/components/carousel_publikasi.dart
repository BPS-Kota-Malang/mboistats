
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:saf/saf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarouselPublikasi extends StatefulWidget {
  const CarouselPublikasi({Key? key}) : super(key: key);

  @override
  _CarouselPublikasiState createState() => _CarouselPublikasiState();
}

class _CarouselPublikasiState extends State<CarouselPublikasi> {
  late Saf saf;
  List<Map<String, dynamic>> dataPublikasi = [];
  String pdfUrl = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://webapi.bps.go.id/v1/api/list/domain/3573/model/publication/lang/ind/id/1/key/9db89e91c3c142df678e65a78c4e547f'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final publications = (data['data'][1] as List).cast<Map<String, dynamic>>();
        setState(() {
          dataPublikasi = publications;
        });
      } else {
        throw Exception('Gagal mendapatkan data.');
      }
    } catch (error) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return dataPublikasi.isEmpty
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
                  'PUBLIKASI',
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
                items: dataPublikasi.map((item) {
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        pdfUrl = item['pdf'] ?? '';
                      });

                      openDownloadConfirmation(context, pdfUrl, item['title']);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        item['cover'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
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

  void openDownloadConfirmation(BuildContext context, String pdfUrl, String pdfTitle) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Unduh"),
          content: const Text("Apakah Anda ingin mengunduh/membuka berkas publikasi ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openPdfDirectly(context, pdfUrl);
              },
              child: const Text("Buka PDF"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Tidak"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await downloadAndShowConfirmation(context, pdfUrl, pdfTitle);
              },
              child: const Text("Unduh"),
            ),
          ],
        );
      },
    );
  }

  Future<void> downloadAndShowConfirmation(BuildContext context, String pdfUrl, String fileName) async {
    // Check if the necessary permissions are granted
    if (await _checkPermission()) {
      try {
        Fluttertoast.showToast(
          msg: "Berkas publikasi sedang diunduh.",
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
              File downloadedFile = File(path);
              String downloadedFileName = downloadedFile.path.split('/').last;
              downloadedFile.rename(path.replaceAll(".html", ".pdf"));
              downloadedFileName = downloadedFileName.replaceAll(".html", ".pdf");

              Fluttertoast.showToast(
                msg: 'Publikasi "$downloadedFileName" telah disimpan dalam Folder Download.',
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
  void openPdfDirectly(BuildContext context, String pdfUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewer(pdfUrl: pdfUrl),
      ),
    );
  }
}

class PDFViewer extends StatelessWidget {
  final String pdfUrl;

  const PDFViewer({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: SfPdfViewer.network(
        pdfUrl,
      ),
    );
  }
}
