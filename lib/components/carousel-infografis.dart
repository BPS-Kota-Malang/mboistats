import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class CarouselInfografis extends StatefulWidget {
  @override
  _CarouselInfografisState createState() => _CarouselInfografisState();
}

class _CarouselInfografisState extends State<CarouselInfografis> {
  List<Map<String, dynamic>> dataInfografis = [];
  String imageUrl = ''; // Variable to store the PDF URL

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://webapi.bps.go.id/v1/api/list/domain/3573/model/infographic/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final publications = (data['data'][1] as List).cast<Map<String, dynamic>>();
      setState(() {
        dataInfografis = publications;
      });
    } else {
      throw Exception('Failed to load data');
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
                  'Infografis',
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
                        openPdfViewer(context, imageUrl);
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

  void openPdfViewer(BuildContext context, String imageUrl) async {
    // Initialize DownloadService
    DownloadService downloadService = DownloadService();

    
    try {
      // Start the download process
      String filePath = await downloadService.download(imageUrl);

      // Check if the download was successful
      if (filePath.isNotEmpty) {
        // Display a dialog with the download confirmation
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Download Complete"),
              content: Text("Image downloaded and saved at: $filePath"),
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
              content: Text("Failed to download image."),
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
            content: Text("Error during image download: $error"),
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

  // ... (rest of the code remains unchanged)
}

class PDFViewer extends StatelessWidget {
  final String imageUrl;

  PDFViewer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.network(
        imageUrl,
      ),
    );
  }
}

class DownloadService {
  Future<String> download(String imageUrl) async {
    var externalDirectory = await getExternalStorageDirectory();
    if(externalDirectory != null){
      var urlImage = imageUrl;
      var dio = Dio();
      var result = await dio.get<List<int>>(urlImage,options: Options(responseType: ResponseType.bytes));
      if(result.statusCode == 200){
        //download sukses
        //mulai proses save data to local
        var byteDownloaded = result.data;
        if(byteDownloaded != null){
          //proses lanjut
          var file = File("${externalDirectory.path}/download-image.jpg");
          file.writeAsBytesSync(byteDownloaded);
          return "${file.path}";
        }else{
          print("file kosong");
          return "error file kosong";
        }

      }else{
        return "download error";
      }
    }else{
      print("external directory null");
      return "error";
    }

  }
}

