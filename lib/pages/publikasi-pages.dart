import 'package:flutter/material.dart';
import 'package:mboistat/datas/publikasi.dart';
import 'package:mboistat/theme.dart';

class PublikasiPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Publikasi'),
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
        body: Center(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Menampilkan 2 kolom
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  images[index].imagePath,
                  width: 600,
                  height: 600,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
