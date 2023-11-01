import 'package:flutter/material.dart';
import 'package:mboistat/datas/kependudukan.dart';
import 'package:mboistat/theme.dart';

class KependudukanPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kependudukan'),
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
            //News
            ...kependudukan.map((item) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: 24, left: 16, right: 16),
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
                      leading: GestureDetector(
                        onTap: () {
                          if (item.route != null) {
                            Navigator.of(context).pushNamed(item.route!);
                          }
                        },
                        child: Image.asset('assets/icons/${item.icons}'),
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
    );
  }
}
