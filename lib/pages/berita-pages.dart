import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



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
        title: Text('Berita'),
      ),
      body: ListView.builder(
        itemCount: beritaData.length,
        itemBuilder: (context, index) {
          final abstract = truncateText(beritaData[index]["abstract"], 150);

          return Card(
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
          );
        },
      ),
    );
  }
}
