import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

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

  @override
  Widget build(BuildContext context) {
    return dataPublikasi.isEmpty
        ? Center(
            child: CircularProgressIndicator()) // Indicator saat sedang memuat
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 24.0,
                    bottom:
                        16.0), // Menambahkan jarak di atas dan di bawah judul
                child: Text(
                  'PUBLIKASI', // Judul "Publikasi"
                  style: TextStyle(
                    fontSize:
                        20, // Sesuaikan ukuran teks dengan preferensi Anda
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 450, // Sesuaikan dengan tinggi kertas A4 dalam piksel
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 3 / 4, // Rasio aspek 3:4 untuk layout kertas A4
                ),
                items: dataPublikasi.map((item) {
                  return Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Lebar gambar mengikuti lebar layar
                    child: Image.network(
                      item['cover'],
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            ],
          );
  }
}
