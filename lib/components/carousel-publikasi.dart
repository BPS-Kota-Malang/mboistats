import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarouselPublikasi extends StatefulWidget {
  @override
  _CarouselPublikasiState createState() => _CarouselPublikasiState();
}

class _CarouselPublikasiState extends State<CarouselPublikasi> {
  List<Map<String, dynamic>> dataPublikasi = [];
  String pdfUrl = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://webapi.bps.go.id/v1/api/list/domain/3573/model/publication/lang/ind/id/1/key/9db89e91c3c142df678e65a78c4e547f'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final publications = (data['data'][1] as List).cast<Map<String, dynamic>>();
        setState(() {
          dataPublikasi = publications;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return dataPublikasi.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
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

                      openPdfViewer(context, pdfUrl, item['title']);
                    },
                    child: Container(
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
  if (Platform.isAndroid) {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      // Request permission and check again
      await Permission.manageExternalStorage.request();
      status = await Permission.manageExternalStorage.status;
      return status.isGranted;
    }
  }
  return true;
}
  void openPdfViewer(BuildContext context, String pdfUrl, String title) {
    BuildContext previousContext = context;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Unduh"),
          content: Text("Apakah Anda ingin mengunduh/membuka file ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openPdfDirectly(previousContext, pdfUrl);
              },
              child: Text("Buka PDF"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Tidak"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await downloadAndShowConfirmation(previousContext, pdfUrl, title);
              },
              child: Text("Unduh"),
            ),
          ],
        );
      },
    );
  }

 Future<void> downloadAndShowConfirmation(
    BuildContext context, String pdfUrl, String fileName) async {
  // Check if the necessary permissions are granted
  if (await _checkPermission()) {
    Fluttertoast.showToast(
      msg: "Mendownload...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    try {
      DownloadService downloadService = DownloadService();
      String filePath = await downloadService.download(pdfUrl, fileName);

      if (filePath.isNotEmpty) {
        Navigator.pop(context); // Close the download dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Informasi Unduhan"),
              content: Text("Berkas publikasi disimpan di $filePath"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        Navigator.pop(context); // Close the download dialog
        Fluttertoast.showToast(
          msg: "Gagal mengunduh file",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      Navigator.pop(context); // Close the download dialog
      Fluttertoast.showToast(
        msg: "Error selama mendownload: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } else {
    // Display a toast message if storage permission is not granted
    Fluttertoast.showToast(
      msg: "Aplikasi belum diizinkan untuk mengakses file",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
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

  PDFViewer({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.network(
        pdfUrl,
      ),
    );
  }
}

class DownloadService {
  Future<String> download(String pdfUrl, String title) async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          var result = await Permission.manageExternalStorage.request();

          if (result != PermissionStatus.granted) {
            Fluttertoast.showToast(
              msg: "Aplikasi ini tidak mengizinkan penyimpanan.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            return "Error: Penyimpanan tidak diizinkan";
          }
        }
      }

      var urlImage = pdfUrl;
      var dio = Dio();
      var result = await dio.get<List<int>>(
        urlImage,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (int received, int total) {
          print('Received: $received, Total: $total');
        },
      );

      if (result.statusCode == 200) {
        var byteDownloaded = result.data;
        if (byteDownloaded != null) {
          var fileName = title.replaceAll(RegExp(r"[^a-zA-Z0-9]+"), "_") + ".pdf";
          var fileDirectory = (await getExternalStorageDirectory())!.path;
          var file = File("$fileDirectory/$fileName");
          await file.writeAsBytes(byteDownloaded);

          if (await file.exists()) {
            return file.path;
          } else {
            return "Error: Failed to save file";
          }
        } else {
          return "Error: Empty File";
        }
      } else {
        return "Error: Download Failed (${result.statusCode})";
      }
    } catch (error) {
      return "Error During Download: $error";
    }
  }
}


