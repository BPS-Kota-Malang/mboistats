import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:mboistat/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PublikasiPages extends StatefulWidget {
  @override
  _PublikasiPagesState createState() => _PublikasiPagesState();
}

class _PublikasiPagesState extends State<PublikasiPages> {
  List<Map<String, dynamic>> dataPublikasi = [];
  List<String> abstraksiBrs = [];

  @override
  void initState() {
    super.initState();
    fetchDataPublikasi();
  }

  Future<void> openPdfViewer(BuildContext context, String pdfUrl) async {
    try {
      String filePath = await download(pdfUrl);

      if (filePath.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Konfirmasi Unduh"),
              content: Text("File downloaded and saved at: $filePath"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    openPdfDirectly(context, filePath);
                  },
                  child: Text("Open PDF"),
                ),
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

  Future<void> showDownloadDialog(BuildContext context, String pdfUrl) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Download Confirmation"),
          content: Text("Do you want to download this publication?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                downloadAndShowConfirmation(context, pdfUrl);
              },
              child: Text("Download"),
            ),
          ],
        );
      },
    );
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

      for (int i = 0; i < dataPublikasi.length; i++) {
        final brsId = dataPublikasi[i]["brs_id"];
        fetchAbstraksiBrs(brsId);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchAbstraksiBrs(String brsId) async {
    final url =
        "https://webapi.bps.go.id/v1/api/list/domain/3573/model/publication/lang/ind/id/1/key/9db89e91c3c142df678e65a78c4e547f";

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
    if (text != null && text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text;
  }

  void _launchPDF(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  }

  Future<void> downloadAndShowConfirmation(
      BuildContext context, String pdfUrl) async {
    try {
      String filePath = await download(pdfUrl);

      if (filePath.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Download Complete"),
              content: Text("File downloaded and saved at: $filePath"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    openPdfDirectly(context, filePath);
                  },
                  child: Text("Open PDF"),
                ),
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

  Future<String> download(String pdfUrl) async {
    var externalDirectory = await getExternalStorageDirectory();
    if (externalDirectory != null) {
      var urlImage = pdfUrl;
      var dio = Dio();
      var result = await dio.get<List<int>>(urlImage,
          options: Options(responseType: ResponseType.bytes));
      if (result.statusCode == 200) {
        var byteDownloaded = result.data;
        if (byteDownloaded != null) {
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

  void openPdfDirectly(BuildContext context, String pdfUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFView(
          filePath: pdfUrl,
          enableSwipe: true,
          swipeHorizontal: false,
        ),
      ),
    );
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
                  leading: Image.asset(
                    'assets/icons/publication.png',
                    width: 40,
                    height: 40,
                  ),
                  title: Text(
                    dataPublikasi[index]["title"],
                    style: bold16.copyWith(color: dark1),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        abstract,
                        style: regular14.copyWith(color: dark2),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.center,
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
}
