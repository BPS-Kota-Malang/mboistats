import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 0; // Indeks awal (Beranda)

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Ambil nama rute halaman yang sedang aktif
    final currentRoute = ModalRoute.of(context)!.settings.name;

    // Tentukan _selectedIndex berdasarkan nama rute halaman yang sedang aktif
    if (currentRoute == '/berita') {
      _selectedIndex = 1;
    } else if (currentRoute == '/contact') {
      _selectedIndex = 2;
    } else {
      _selectedIndex = 0; // Default ke Beranda jika tidak ada rute yang cocok
    }
  }

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
            .pushNamed('/berita'); // Ganti dengan rute yang sesuai
        break;
      case 2:
        Navigator.of(context)
            .pushNamed('/contact'); // Ganti dengan rute yang sesuai
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Intersep saat tombol kembali ditekan
        if (_selectedIndex != 0) {
          // Jika tidak berada di halaman beranda, navigasi kembali ke halaman beranda
          Navigator.of(context).pushNamed('/main');
          return false; // Jangan pop rute saat ini
        }
        return true; // Izinkan popping rute saat ini (keluar dari aplikasi)
      },
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _selectedIndex == 0 ? Colors.blue : null, // Home
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.newspaper_outlined,
              color: _selectedIndex == 1 ? Colors.blue : null, // News
            ),
            label: 'BRS',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contacts,
              color: _selectedIndex == 2 ? Colors.blue : null, // Contact
            ),
            label: 'Kontak',
          ),
        ],
      ),
    );
  }
  }

