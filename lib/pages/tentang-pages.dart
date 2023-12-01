import 'package:flutter/material.dart';
import 'package:mboistat/datas/tentang.dart';
import 'package:mboistat/theme.dart';

class TentangPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang BPS Kota Malang'),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Center(
              child: Container(
                width: 200, // Lebar container sesuai dengan lebar ikon telepon
                height:
                    200, // Tinggi container sesuai dengan tinggi ikon telepon
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/icons/office.png'), // Path ikon telepon
                    fit: BoxFit.cover, // Sesuaikan dengan tata letak gambar
                  ),
                ),
              ),
            ),
            SizedBox(
                height:
                    10), // Tambahkan SizedBox dengan ketinggian yang diinginkan
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 16.0), // Jarak di bawah judul
                child: Column(),
              ),
            ),
            ...tentang.map((item) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: dark4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          item.title,
                          style: bold16.copyWith(color: dark1),
                        ),
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center, // Rata tengah
                        child: Text(
                          item.description,
                          style: regular14.copyWith(color: dark2),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
