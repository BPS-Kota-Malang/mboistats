import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
      BottomNavigationBarItem(
  icon: Image.asset("assets/icons/faq.png", width: 24, height: 24), // Sesuaikan ukuran sesuai kebutuhan Anda
  label: 'FAQ',
),

        BottomNavigationBarItem(
          icon: Image.asset("assets/icons/telephone.png"),
          label: 'Kontak',
        ),
      ],
    );
  }
}
