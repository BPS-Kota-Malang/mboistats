import 'package:flutter/material.dart';
import 'package:mboistat/datas/infografis.dart';
import 'package:mboistat/theme.dart';

class InfografisPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Infografis'),
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/left-arrow.png',
              height: 18,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Menavigasi kembali ke halaman sebelumnya
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             const SizedBox(
              height: 24,
            ),
            Center(
              child: Padding(
                padding:
                  const EdgeInsets.only(bottom: 16.0), // Jarak di bawah judul
                child: Text(
                  'INFOGRAFIS TERBARU', // Ganti dengan judul yang sesuai
                  style: bold16.copyWith(color: dark1),
              ),
            ),
            ),

            Expanded(
              child: Center(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Menampilkan 2 kolom
                    mainAxisSpacing: 0.0, // Jarak vertikal antara elemen-elemen dalam grid
                    crossAxisSpacing: 0.0, // Jarak horizontal antara elemen-elemen dalam grid
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16), 
                      child: Image.asset(
                        images[index].imagePath,
                        // width: 600,
                        // height: 600,
                         fit: BoxFit.cover, // Sesuaikan dengan tata letak gambar
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
    );
  }
}
