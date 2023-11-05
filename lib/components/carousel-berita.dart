import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselBerita extends StatefulWidget {
  @override
  _CarouselBeritaState createState() => _CarouselBeritaState();
}

class _CarouselBeritaState extends State<CarouselBerita> {
  List<Map<String, dynamic>> dataBerita = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://webapi.bps.go.id/v1/api/list/model/pressrelease/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final images = (data['data'][1] as List).cast<Map<String, dynamic>>();
      setState(() {
        dataBerita = images;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return dataBerita.isEmpty
        ? Center(child: CircularProgressIndicator()) // Indicator saat sedang memuat
        : Column(
            children: [
              Text(
                'BERITA RESMI STATISTIK', // Judul "Infografis"
                style: TextStyle(
                  fontSize: 24, // Sesuaikan ukuran teks dengan preferensi Anda
                  fontWeight: FontWeight.bold,
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 450, // Sesuaikan dengan tinggi kertas A4 dalam piksel
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 3 / 4, // Rasio aspek 3:4 untuk layout kertas A4
                ),
                items: dataBerita.map((item) {
                  return Container(
                    width: MediaQuery.of(context).size.width, // Lebar gambar mengikuti lebar layar
                    child: Image.network(
                      item['thumbnail'],
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            ],
          );
  }
}


