import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 0; // Indeks awal (Beranda)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        Navigator.of(context)
            .pushNamed('/main'); // Ganti dengan rute yang sesuai
        break;
      case 1:
        Navigator.of(context)
            .pushNamed('/faq'); // Ganti dengan rute yang sesuai
        break;
      case 2:
        Navigator.of(context)
            .pushNamed('/contact'); // Ganti dengan rute yang sesuai
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _selectedIndex == 0 ? Colors.blue : null, // Beranda
          ),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.question_answer_outlined,
            color: _selectedIndex == 1 ? Colors.blue : null, // FAQ
          ),
          label: 'FAQ',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.contacts,
            color: _selectedIndex == 2 ? Colors.blue : null, // Kontak
          ),
          label: 'Kontak',
        ),
      ],
    );
  }
}