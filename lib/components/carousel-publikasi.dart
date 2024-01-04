import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

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
                      openPdfViewer(context, pdfUrl);
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

  void openPdfViewer(BuildContext context, String pdfUrl) {
    // Simpan konteks sebelumnya
    BuildContext previousContext = context;

    // Show a dialog to confirm whether to download the file
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Unduh"),
          content: Text("Apakah Anda ingin mendownload/membuka file ini?"),
          actions: [
            TextButton(
              onPressed: () async {
                // Close the dialog and proceed with the download
                Navigator.pop(context);
                await downloadAndShowConfirmation(previousContext, pdfUrl);
              },
              child: Text("Ya"),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog and open the PDF directly
                Navigator.pop(context);
                openPdfDirectly(previousContext, pdfUrl);
              },
              child: Text("Buka PDF"),
            ),
          ],
        );
      },
    );
  }

  Future<void> downloadAndShowConfirmation(
      BuildContext context, String pdfUrl) async {
    try {
      // Initialize DownloadService
      DownloadService downloadService = DownloadService();

      // Start the download process
      String filePath = await downloadService.download(pdfUrl);

      if (filePath.isNotEmpty) {
        // Display a dialog with the download confirmation
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Download Complete"),
              content: Text("File downloaded and saved at: $filePath"),
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
  Future<String> download(String pdfUrl) async {
    var externalDirectory = await getExternalStorageDirectory();
    if (externalDirectory != null) {
      var urlImage = pdfUrl;
      var dio = Dio();
      var result = await dio.get<List<int>>(urlImage,
          options: Options(responseType: ResponseType.bytes));
      if (result.statusCode == 200) {
        //download sukses
        //mulai proses save data to local
        var byteDownloaded = result.data;
        if (byteDownloaded != null) {
          //proses lanjut
          var file = File("${externalDirectory.path}/download-publikasi.pdf");
          file.writeAsBytesSync(byteDownloaded);
          return "${file.path}";
        } else {
          print("file kosong");
          return "error file kosong";
        }
      } else {
        return "download error";
      }
    } else {
      print("external directory null");
      return "error";
    }
  }
}
