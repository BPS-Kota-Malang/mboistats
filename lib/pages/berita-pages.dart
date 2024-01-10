import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mboistat/components/footer.dart';
import 'package:mboistat/theme.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class BeritaPages extends StatefulWidget {
  @override
  _BeritaPagesState createState() => _BeritaPagesState();
}

class _BeritaPagesState extends State<BeritaPages> {
  List<Map<String, dynamic>> dataPublikasi = [];
  List<String> abstraksiBrs = [];

  @override
  void initState() {
    super.initState();
    fetchDataPublikasi();
  }

  Future<void> fetchDataPublikasi() async {
    final String apiUrl =
        "https://webapi.bps.go.id/v1/api/list/model/pressrelease/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final publikasi = parsedResponse["data"][1];

      setState(() {
        dataPublikasi = List<Map<String, dynamic>>.from(publikasi);
      });

      for (int i = 0; i < dataPublikasi.length; i++) {
        final brsId = dataPublikasi[i]["brs_id"];
        await fetchAbstraksiBrs(brsId);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchAbstraksiBrs(String brsId) async {
    final url =
        "https://webapi.bps.go.id/v1/api/list/model/pressrelease/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final abstraksi = parsedResponse['data'][2];

      setState(() {
        abstraksiBrs.add(abstraksi);
      });
    } else {
      throw Exception('Failed to load abstraksi');
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
            Image.asset(
              'assets/images/Mbois-stat Logo_Fix Putih.png',
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: dataPublikasi.length,
        itemBuilder: (context, index) {
          final abstract = truncateText(
              abstraksiBrs.length > index ? abstraksiBrs[index] : '', 150);

          return Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: InkWell(
              onTap: () {
                String pdfUrl = dataPublikasi[index]["pdf"];
                showDownloadDialog(context, pdfUrl, index);
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
                    'assets/icons/news.png',
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
      bottomNavigationBar: Footer(),
    );
  }

  void showDownloadDialog(BuildContext context, String pdfUrl, int index) {
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
                openPdfDirectly(context, pdfUrl);
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
                await downloadAndShowConfirmation(context, pdfUrl, index);
              },
              child: Text("Unduh"),
            ),
          ],
        );
      },
    );
  }

  Future<void> downloadAndShowConfirmation(
      BuildContext context, String pdfUrl, int index) async {
    try {
      DownloadService downloadService = DownloadService();
      String filePath = await downloadService.download(pdfUrl, dataPublikasi[index]["title"]);

      if (filePath.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Unduhan Selesai"),
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
              title: Text("Download Failed"),
              content: Text("Failed to download file."),
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
            content: Text("Error during file download: $error"),
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
    var externalDirectory = await getExternalStorageDirectory();
    if (externalDirectory != null) {
      var urlImage = pdfUrl;
      var dio = Dio();
      var result = await dio.get<List<int>>(urlImage,
          options: Options(responseType: ResponseType.bytes));
      if (result.statusCode == 200) {
        var byteDownloaded = result.data;
        if (byteDownloaded != null) {
          var fileName = title.replaceAll(RegExp(r"[^\w\s]+"), "") + ".pdf";
          var file = File("/storage/emulated/0/Download/$fileName");
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
