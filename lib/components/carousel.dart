import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';



class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200, // Sesuaikan tinggi sesuai kebutuhan Anda
        enlargeCenterPage: true,
        autoPlay: true, // Aktifkan otomatis bermain
        aspectRatio: 16 / 9, // Sesuaikan rasio aspek sesuai kebutuhan Anda
      ),
      items: [
        // Daftar widget yang akan ditampilkan dalam carousel
        Image.asset(
          'assets/images/Rectangle8.png',
          fit: BoxFit.cover, // Sesuaikan tampilan gambar sesuai kebutuhan Anda
        ),
        Image.asset(
          'assets/images/gambar2.png',
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/images/gambar3.png',
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

