import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mboistat/theme.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class PublikasiPage extends StatefulWidget {
  @override
  _PublikasiPageState createState() => _PublikasiPageState();
}

class _PublikasiPageState extends State<PublikasiPage> {
  List<Map<String, dynamic>> dataPublikasi = [];
  List<String> abstraksiBrs = [];
  String pdfUrl = '';

  @override
  void initState() {
    super.initState();
    fetchDataPublikasi();
  }

  Future<void> fetchDataPublikasi() async {
    final String apiUrl =
        "https://webapi.bps.go.id/v1/api/list/domain/3573/model/publication/lang/ind/id/1/key/9db89e91c3c142df678e65a78c4e547f";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final publikasi = parsedResponse["data"][1];

      setState(() {
        dataPublikasi = List<Map<String, dynamic>>.from(publikasi);
      });

    } else {
      throw Exception('Failed to load data');
    }
  }


  String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publikasi'),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/left-arrow.png',
            height: 25,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: dataPublikasi.length,
        itemBuilder: (context, index) {
          final abstract = truncateText(
              abstraksiBrs.length > index ? abstraksiBrs[index] : '', 150);
            // showToastMessage(dataPublikasi.length.toString());
          return Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: InkWell(
              onTap: () {
                String pdfUrl = dataPublikasi[index]["pdf"];
                
                showDownloadDialog(context, pdfUrl);
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: dark4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  leading: Image.asset(
                    'assets/icons/publication.png',
                    width: 40,
                    height: 40,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          dataPublikasi[index]["title"],
                          style: bold16.copyWith(color: dark1),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          'assets/icons/right-arrow.png',
                          height: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showDownloadDialog(BuildContext context, String pdfUrl) {
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
                showToastMessage(pdfUrl);
                await downloadAndShowConfirmation(previousContext, pdfUrl);
              },
              child: Text("Unduh"),
            ),
          ],
        );
      },
    );
  }




   Future<void> downloadAndShowConfirmation(
      BuildContext context, String pdfUrl) async {
    try {
      DownloadService downloadService = DownloadService();
      String filePath = await downloadService.download(pdfUrl);

      if (filePath.isNotEmpty) {
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
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Unduhan Gagal"),
              content: Text("Gagal Mengunduh File"),
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
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(
                "Akses Ditolak, Tolong izinkan aplikasi ini untuk mengakses file"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings(); // Open app settings to allow the user to grant permissions
                },
                child: Text("Buka Pengaturan Aplikasi"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Tutup"),
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

void showToastMessage(String pdfUrl) {
  Fluttertoast.showToast(
        msg: pdfUrl,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

class DownloadService {
  Future<String> download(String pdfUrl) async {
    try {
      // Request runtime permissions if not granted
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          await Permission.manageExternalStorage.request();
        }
      }

      var urlImage = pdfUrl;
      var dio = Dio();
      var result = await dio.get<List<int>>(urlImage,
          options: Options(responseType: ResponseType.bytes));

      if (result.statusCode == 200) {
        var byteDownloaded = result.data;
        if (byteDownloaded != null) {
          var file = File("/storage/emulated/0/Download/download-publikasi.pdf");
          await file.writeAsBytes(byteDownloaded);

          return file.path;
        } else {
          return "Error: File is empty";
        }
      } else {
        return "Download error: ${result.statusCode}";
      }
    } catch (error) {
      return "Error during file download: $error";
    }
  }
}

