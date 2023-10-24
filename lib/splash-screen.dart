import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double opacity = 1.0; // Nilai opasitas awal
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    // Menggunakan Future.delayed untuk mengatur animasi
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacity = 0.0; // Mengubah opasitas menjadi 0 untuk menghilangkan tulisan
      });

      // Navigasi ke halaman beranda setelah animasi selesai
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/main');
      });
    });

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 1),
              child: Image.asset(
                'assets/icons/MboistatLogo.png',
                width: 200,
                height: 200,
              ),
            ),
           AnimatedPositioned(
  top: 130, // Ganti nilai top sesuai keinginan
  duration: Duration(seconds: 1),
  child: AnimatedOpacity(
    opacity: opacity,
    duration: Duration(seconds: 1),
    child: const Text(
      "MBOIStats+",
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(221, 219, 95, 12),
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
