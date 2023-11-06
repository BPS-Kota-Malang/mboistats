import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselPublikasi extends StatefulWidget {
  @override
  _CarouselPublikasiState createState() => _CarouselPublikasiState();
}

class _CarouselPublikasiState extends State<CarouselPublikasi> {
  List<Map<String, dynamic>> dataPublikasi = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://webapi.bps.go.id/v1/api/list/domain/3573/model/publication/lang/ind/id/1/key/9db89e91c3c142df678e65a78c4e547f'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final images = (data['data'][1] as List).cast<Map<String, dynamic>>();
      setState(() {
        dataPublikasi = images;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void launchPDF(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  }

  void downloadPDF(String pdfUrl) async {
    // Implementasi unduhan PDF di sini, contohnya:
    // await launch(pdfUrl);
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
                    onTap: () {
                      // Saat gambar ditekan, jalankan atau unduh PDF
                      launchPDF(item['pdf']);
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
}
