import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Berita'),
      ),
      body: ListView.builder(
        itemCount: beritaData.length,
        itemBuilder: (context, index) {
          final abstract = truncateText(abstraksiBrs.length > index ? abstraksiBrs[index] : '', 150);

          return GestureDetector(
            onTap: () {
              String pdfUrl = beritaData[index]["pdf"];
              _launchPDF(pdfUrl);
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      beritaData[index]["title"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      abstract,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
