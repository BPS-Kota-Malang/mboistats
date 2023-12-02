import 'package:flutter/material.dart';
import 'package:mboistat/components/footer.dart';
import 'package:mboistat/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class BeritaPages extends StatefulWidget {
  @override
  _BeritaPagesState createState() => _BeritaPagesState();
}

class _BeritaPagesState extends State<BeritaPages> {
  List<Map<String, dynamic>> beritaData = [];
  List<String> abstraksiBrs = [];

  @override
  void initState() {
    super.initState();
    fetchBeritaData();
  }

  Future<void> fetchBeritaData() async {
    final String apiUrl =
        "https://webapi.bps.go.id/v1/api/list/model/pressrelease/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final berita = parsedResponse["data"][1];

      setState(() {
        beritaData = List<Map<String, dynamic>>.from(berita);
      });

      for (int i = 0; i < beritaData.length; i++) {
        final brsId = beritaData[i]["brs_id"];
        fetchAbstraksiBrs(brsId);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchAbstraksiBrs(String brsId) async {
    final url =
        "https://webapi.bps.go.id/v1/api/list/model/pressrelease/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final abstraksi = parsedResponse['data'][2];

      setState(() {
        abstraksiBrs.add(abstraksi);
      });
    } else {
      throw Exception('Failed to load abstraksi');
    }
  }

  String truncateText(String text, int maxLength) {
    if (text != null && text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text;
  }

  void _launchPDF(String pdfUrl) async {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  }

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
      body: ListView.builder(
        itemCount: beritaData.length,
        itemBuilder: (context, index) {
          final abstract = truncateText(abstraksiBrs.length > index ? abstraksiBrs[index] : '', 150);

          return Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: InkWell(
              onTap: () {
                String pdfUrl = beritaData[index]["pdf"];
                _launchPDF(pdfUrl);
              },
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
                        'assets/icons/news.png', 
                        width: 40, height: 40, 
                      ),
                      title: Text(
                        beritaData[index]["title"],
                        style: bold16.copyWith(color: dark1),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            abstract,
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
              )
            )
          );
        },
      ),
       bottomNavigationBar: Footer(),
    );
  }
}
