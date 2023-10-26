import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselTentang extends StatelessWidget {
  const CarouselTentang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Padding untuk Carousel
      color: Colors.grey[
          200], // Latar belakang abu-abu (ganti dengan warna yang Anda inginkan)
      child: Column(
        children: [
          Text(
            'TENTANG BPS KOTA MALANG',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16), // Jarak antara teks dan Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 200, // Sesuaikan tinggi sesuai kebutuhan Anda
              enlargeCenterPage: true,
              autoPlay: true, // Aktifkan otomatis bermain
              aspectRatio:
                  16 / 9, // Sesuaikan rasio aspek sesuai kebutuhan Anda
            ),
            items: [
              // Daftar widget yang akan ditampilkan dalam carousel
              Image.asset(
                'assets/images/Rectangle8.png',
                fit: BoxFit
                    .cover, // Sesuaikan tampilan gambar sesuai kebutuhan Anda
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
          ),
        ],
      ),
    );
  }
}
