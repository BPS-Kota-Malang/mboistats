import 'package:flutter/material.dart';
import 'package:mboistat/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class InfografisPages extends StatefulWidget {
  @override
  _InfografisPagesState createState() => _InfografisPagesState();
}

class _InfografisPagesState extends State<InfografisPages> {
  List<Map<String, dynamic>> dataInfografis = [];
  List<String> abstraksiBrs = [];

  @override
  void initState() {
    super.initState();
    fetchDataInfografis();
  }

  Future<void> fetchDataInfografis() async {
    final String apiUrl =
        "https://webapi.bps.go.id/v1/api/list/domain/3573/model/infographic/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      final infografis = parsedResponse["data"][1];

      setState(() {
        dataInfografis = List<Map<String, dynamic>>.from(infografis);
      });

      for (int i = 0; i < dataInfografis.length; i++) {
        final brsId = dataInfografis[i]["brs_id"];
        fetchAbstraksiBrs(brsId);
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchAbstraksiBrs(String brsId) async {
    final url =
        "https://webapi.bps.go.id/v1/api/list/domain/3573/model/infographic/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f";

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
  try {
    if (await canLaunch(pdfUrl)) {
      await launch(pdfUrl, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $pdfUrl';
    }
  } catch (e) {
    // Handle exceptions, if any
    print('Error launching PDF: $e');
  }
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INFOGRAFIS'),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/left-arrow.png',
            height: 18,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: dataInfografis.length,
        itemBuilder: (context, index) {
          final abstract = truncateText(abstraksiBrs.length > index ? abstraksiBrs[index] : '', 150);

          return GestureDetector(
            onTap: () {
              String pdfUrl = dataInfografis[index]["dl"];
              _launchPDF(pdfUrl);
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Image.asset(
                        'assets/icons/infographics.png', 
                        width: 40, height: 40, 
                      ),
                      title: Text(
                        dataInfografis[index]["title"],
                        style: bold16.copyWith(color: dark1),
                      ),
                      subtitle: Text(
                        abstract,
                        style: TextStyle(fontSize: 16),
                      ),
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


