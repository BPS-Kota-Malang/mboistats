import 'package:flutter/material.dart';
import 'package:mboistat/components/buttonSection.dart';
import 'package:mboistat/components/carousel.dart';
import 'package:mboistat/components/footer.dart';
import 'package:mboistat/components/menus.dart';
import 'package:mboistat/components/pictures.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 71,
        title: const Text(
          'MBOIStats+',
          style: TextStyle(color: Colors.black),
        ),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/icons/MboistatLogo.png', width: 40, height: 50),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Menus(), Carousel(), ButtonSection(), Pictures()],
      )),
      bottomNavigationBar: Footer(),
    );
  }
}
