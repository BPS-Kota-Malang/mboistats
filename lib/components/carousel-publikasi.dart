import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class CarouselPublikasi extends StatefulWidget {
  @override
  _CarouselPublikasiState createState() => _CarouselPublikasiState();
}

class _CarouselPublikasiState extends State<CarouselPublikasi> {
  List<Map<String, dynamic>> dataPublikasi = [];
  String pdfUrl = ''; // Variable to store the PDF URL

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'http://webapi.bps.go.id/v1/api/list/domain/3573/model/publication/lang/ind/id/1/key/9db89e91c3c142df678e65a78c4e547f'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final publications =
          (data['data'][1] as List).cast<Map<String, dynamic>>();
      setState(() {
        dataPublikasi = publications;
      });
    } else {
      throw Exception('Failed to load data');
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

                      // Show a dialog to confirm whether to download the file
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

  void openPdfViewer(BuildContext context, String pdfUrl, String title) {
    // Simpan konteks sebelumnya
    BuildContext previousContext = context;

    // Show a dialog to confirm whether to download the file
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Unduh"),
          content: Text("Apakah Anda ingin mengunduh/membuka file ini?"),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog and open the PDF directly
                Navigator.pop(context);
                openPdfDirectly(previousContext, pdfUrl);
              },
              child: Text("Buka PDF"),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog and cancel download
                Navigator.pop(context, false);
              },
              child: Text("Tidak"),
            ),
            TextButton(
              onPressed: () async {
                // Close the dialog and proceed with the download
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
      BuildContext context, String pdfUrl, String title) async {
    try {
      // Initialize DownloadService
      DownloadService downloadService = DownloadService();

      // Start the download process
      String filePath = await downloadService.download(pdfUrl, title);

      if (filePath.isNotEmpty) {
        // Display a dialog with the download confirmation
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Konfirmasi Unduhan"),
              content: Text("Berkas publikasi '$title' disimpan di $filePath"),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // Display a dialog for download failure
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Download Failed"),
              content: Text("Failed to download file."),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Display a dialog for unexpected errors
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Error during file download: $error"),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
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
      // Request runtime permissions if not granted
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          await Permission.manageExternalStorage.request();
          
          // Check permission status again after requesting
          status = await Permission.manageExternalStorage.status;
          if (!status.isGranted) {
            return "Error: Penyimpanan tidak diizinkan";
          }
        }
      }

      var urlImage = pdfUrl;
      var dio = Dio();
      var result = await dio.get<List<int>>(urlImage,
          options: Options(responseType: ResponseType.bytes));

      if (result.statusCode == 200) {
        var byteDownloaded = result.data;
        if (byteDownloaded != null) {
          // Use the "title" to construct the filename
          var fileName = title.replaceAll(RegExp(r"[^a-zA-Z0-9]+"), "_") + ".pdf";
          var file = File("/storage/emulated/0/Download/$fileName");
          await file.writeAsBytes(byteDownloaded);

          return file.path;
        } else {
          return "Error: File Kosong";
        }
      } else {
        // return "Download Gagal: ${result.statusCode}";
        return "Download Gagal";
      }
    } catch (error) {
      // return "Error during file download: $error";
      return "Error Selama Mendownload ";
    }
  }
}
