import 'package:flutter/material.dart';
import 'package:mboistat/components/footer.dart';
import 'package:mboistat/datas/contact.dart';
import 'package:mboistat/theme.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 50,
        title: const Text(
          'MBOIStatS+',
          style: TextStyle(color: Colors.black),
        ),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/Mbois-stat Logo_Fix Putih.png',
              width: 40,
              height: 40,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding di dalam ScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 10),
              Center(
                child: Container(
                  width: 200, // Lebar container sesuai dengan lebar ikon telepon
                  height: 200, // Tinggi container sesuai dengan tinggi ikon telepon
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/communication.png'), // Path ikon telepon
                      fit: BoxFit.cover, // Sesuaikan dengan tata letak gambar
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10), // Tambahkan SizedBox dengan ketinggian yang diinginkan
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0), // Jarak di bawah judul
                  child: Column(
                    children: [
                      Text(
                        'Kontak Kami', // Ganti dengan judul yang sesuai
                        style: bold16.copyWith(color: dark1, height: 1.5), // Sesuaikan gaya teks
                      ),
                      Text(
                        'Kami siap membantu Anda. Hubungi kami untuk informasi lebih lanjut', // Teks tambahan di bawah judul
                        style: regular14.copyWith(color: dark2, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16), // Tambahkan SizedBox dengan ketinggian yang diinginkan
              ...contact.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: dark4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.2), // Warna abu-abu transparan
                        spreadRadius: 2, // Seberapa tersebar bayangannya
                        blurRadius: 4, // Seberapa kabur bayangannya
                        offset:
                            Offset(0, 2), // Perpindahan bayangan dari widget
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Image.asset(
                        'assets/icons/${item.icons}'), // Ikon di sini
                    title: Text(
                      item.title,
                      style: bold16.copyWith(color: dark1),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          item.description,
                          style: regular14.copyWith(color: dark2),
                        ),
                        Spacer(), // Spacer untuk memberikan jarak antara teks dan ikon
                        Align(
                          alignment:
                              Alignment.center, // Mengatur ikon di tengah
                          child: Image.asset(
                            'assets/icons/right-arrow.png',
                            height: 16,
                          ), // Ikon panah ke kanan
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}
