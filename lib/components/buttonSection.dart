// import 'package:flutter/material.dart';

// class ButtonSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent, // Latar belakang transparan
//       margin: EdgeInsets.only(top: 8.0, left: 8.0), // Menambahkan jarak ke atas dan kiri
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal, // Mengaktifkan scroll horizontal
//         child: Row(
//           children: [
//             _buildButton("Berita Resmi Statistik", Colors.blue),
//             _buildButton("Infografis", Colors.blue),
//             _buildButton("Tentang Kami", Colors.blue),
//             _buildButton("Button 4", Colors.blue), // Contoh penambahan tombol
//             _buildButton("Button 5", Colors.blue), // Contoh penambahan tombol
//             // Tambahkan tombol lain sesuai kebutuhan
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(String text, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Atur jarak di dalam tombol
//       decoration: BoxDecoration(
//         border: Border.all(color: color), // Garis tepi biru
//         borderRadius: BorderRadius.circular(20.0), // Bentuk sudut tombol
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color, // Warna teks biru
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Latar belakang transparan
      margin: EdgeInsets.only(
          top: 8.0, left: 8.0), // Menambahkan jarak ke atas dan kiri
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Mengaktifkan scroll horizontal
        child: Row(
          children: [
            _buildButton("Berita Resmi Statistik", Colors.blue),
            SizedBox(width: 16.0), // Jarak horizontal antara tombol
            _buildButton("Infografis", Colors.blue),
            SizedBox(width: 16.0), // Jarak horizontal antara tombol
            _buildButton("Tentang Kami", Colors.blue),
            SizedBox(width: 16.0), // Jarak horizontal antara tombol
            _buildButton("Lainnya", Colors.blue), // Contoh penambahan tombol
            SizedBox(width: 16.0), // Jarak horizontal antara tombol
            // Tambahkan tombol lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0), // Atur jarak di dalam tombol
      decoration: BoxDecoration(
        border: Border.all(color: color), // Garis tepi biru
        borderRadius: BorderRadius.circular(20.0), // Bentuk sudut tombol
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color, // Warna teks biru
        ),
      ),
    );
  }
}
