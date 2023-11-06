import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berita App',
      home: BeritaPages(),
    );
  }
}

class BeritaPages extends StatefulWidget {
  @override
  _BeritaPagesState createState() => _BeritaPagesState();
}

class _BeritaPagesState extends State<BeritaPages> {
  List<Map<String, dynamic>> beritaData = [];

  @override
  void initState() {
    super.initState();
    fetchBeritaData();
  }

  Future<void> fetchBeritaData() async {
    final String apiUrl =
        "https://webapi.bps.go.id/v1/api/list/domain/3573/model/publication/lang/ind/id/1/key/9db89e91c3c142df678e65a78c4e547f";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final berita = parsedResponse["data"][1];

      setState(() {
        beritaData = List<Map<String, dynamic>>.from(berita);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita Resmi Statistik'),
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
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 16.0), // Jarak di bawah judul
                child: Text(
                  'BERITA RESMI STATISTIK', // Ganti dengan judul yang sesuai
                  style: bold16.copyWith(color: dark1), // Sesuaikan gaya teks
                ),
              ),
            ),
            ...berita.map((item) => Padding(
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
                      leading: Image.asset('assets/icons/${item.icons}'),
                      title: Text(
                        item.title,
                        style: bold16.copyWith(color: dark1),
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.all(8),
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
      bottomNavigationBar: Footer(),
    );
  }
}
