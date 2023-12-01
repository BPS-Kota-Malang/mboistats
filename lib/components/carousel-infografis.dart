import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselInfografis extends StatefulWidget {
  @override
  _CarouselInfografisState createState() => _CarouselInfografisState();
}

class _CarouselInfografisState extends State<CarouselInfografis> {
  List<Map<String, dynamic>> dataInfografis = [];

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
      final publications =
          (data['data'][1] as List).cast<Map<String, dynamic>>();
      setState(() {
        dataInfografis = publications;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> downloadPDF(String pdfUrl) async {
    try {
      // Buka URL dengan aplikasi WebView internal
      await launch(pdfUrl, forceSafariVC: false, forceWebView: false);
    } catch (error) {
      print('Gagal membuka URL: $error');
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
                      // Saat gambar ditekan, buka URL dengan url_launcher
                      if (item['dl'] != null && item['dl'].isNotEmpty) {
                        downloadPDF(item['dl']);
                      } else {
                        print('URL tidak tersedia');
                      }
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
}
