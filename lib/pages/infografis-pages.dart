import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mboistat/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InfografisPages extends StatefulWidget {
  @override
  _InfografisPagesState createState() => _InfografisPagesState();
}

class _InfografisPagesState extends State<InfografisPages> {
  List<Map<String, dynamic>> dataInfografis = [];
  List<String> abstraksiBrs = [];
  String imageUrl = ''; // Variable to store the PDF URL

  @override
  void initState() {
    super.initState();
    fetchDataInfografis();
  }

  Future<void> fetchDataInfografis() async {
    final String apiUrl =
        "https://webapi.bps.go.id/v1/api/list/domain/3573/model/infographic/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final infografis = parsedResponse["data"][1];

      setState(() {
        dataInfografis = List<Map<String, dynamic>>.from(infografis);
      });

      for (int i = 0; i < dataInfografis.length; i++) {
        final brsId = dataInfografis[i]["brs_id"];
        fetchAbstraksiBrs(brsId);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchAbstraksiBrs(String brsId) async {
    final url =
        "https://webapi.bps.go.id/v1/api/list/domain/3573/model/infographic/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f";

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

  void openDownloadConfirmation(BuildContext context, String imageUrl, String title) async {
    try {
      bool confirmDownload = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Konfirmasi Unduh"),
            content: Text("Apakah Anda ingin mengunduh file ini?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text("Ya"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("Tidak"),
              ),
            ],
          );
        },
      );

      if (confirmDownload == true) {
        prosesDownload(context, imageUrl, title);
      }
    } catch (error) {}
  }

  Future<void> prosesDownload(BuildContext context, String imageUrl, String title) async {
    try {
      // Meminta izin penyimpanan eksternal
      var status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        // await Permission.manageExternalStorage.request();

        // Cek status izin lagi setelah meminta izin
        status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          _showToast(context, "Error: Penyimpanan tidak diizinkan");
          return;
        }
      }

      DownloadService downloadService = DownloadService();
      String filePath = await downloadService.download(imageUrl, title);

      if (filePath.isNotEmpty) {
        _showDialog(context, "Unduh Selesai", "Berkas infografis '$title' disimpan di $filePath");
      } else {
        _showDialog(context, "Unduh Gagal", "Gagal mengunduh file.");
      }
    } catch (error) {
      _showDialog(context, "Error", "Terjadi kesalahan saat mengunduh file: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infografis'),
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
        itemCount: dataInfografis.length,
        itemBuilder: (context, index) {
          final abstract = truncateText(
              abstraksiBrs.length > index ? abstraksiBrs[index] : '', 150);

          return Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: InkWell(
              onTap: () {
                String imageUrl = dataInfografis[index]["dl"];
                String title = dataInfografis[index]["title"];
                openDownloadConfirmation(context, imageUrl, title);
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
                    'assets/icons/infographics.png',
                    width: 40,
                    height: 40,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          dataInfografis[index]["title"],
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

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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

  void _showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

class DownloadService {
  Future<String> download(String pdfUrl, String title) async {
    try {
      var externalDirectory = await getExternalStorageDirectory();
      if (externalDirectory != null) {
        var urlImage = pdfUrl;
        var dio = Dio();
        var result = await dio.get<List<int>>(urlImage,
            options: Options(responseType: ResponseType.bytes));

        if (result.statusCode == 200) {
          var byteDownloaded = result.data;
          if (byteDownloaded != null) {
            var fileName = title.replaceAll(RegExp(r"[^\w\s]+"), "") + ".jpg";
            var file = File("${externalDirectory.path}/Download/$fileName");
            file.writeAsBytesSync(byteDownloaded);
            return "${file.path}";
          } else {
            return "error file kosong";
          }
        } else {
          return "download error";
        }
      } else {
        return "error";
      }
    } catch (error) {
      return "error";
    }
  }
}
