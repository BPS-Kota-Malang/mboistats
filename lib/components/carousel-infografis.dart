import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselInfografis extends StatefulWidget {
  @override
  _CarouselInfografisState createState() => _CarouselInfografisState();
}

class _CarouselInfografisState extends State<CarouselInfografis> {
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
        Uri.parse(
          'https://webapi.bps.go.id/v1/api/list/domain/3573/model/infographic/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final publications =
            (data['data'][1] as List).cast<Map<String, dynamic>>();
        setState(() {
          dataInfografis = publications;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return dataInfografis.isEmpty
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
                        imageUrl = item['dl'] ?? '';
                        openDownloadConfirmation(context, imageUrl, item['title']);
                      });
                    },
                    child: Container(
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
        saveImage(imageUrl, title);
      }
    } catch (error) {
      print("Error opening download confirmation: $error");
    }
  }

  Future<void> saveImage(String url, String fileName) async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
          status = await Permission.storage.status;
          if (!status.isGranted) {
            throw Exception("Error: Penyimpanan tidak diizinkan");
          }
        }
      }

      Directory? directory = await getExternalStorageDirectory();
      String newPath = "";
      List<String> paths = directory!.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
      newPath = newPath + "/PDF_Download";
      directory = Directory(newPath);

      File saveFile = File(directory.path + "/$fileName.jpg");
      if (kDebugMode) {
        print(saveFile.path);
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await Dio().download(
          url,
          saveFile.path,
        );

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Unduhan Selesai"),
              content: Text("Berkas infografis disimpan di ${saveFile.path}"),
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
      print("Error during file download: $error");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Unduhan Gagal"),
            content: Text("Gagal Mengunduh File."),
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
}
