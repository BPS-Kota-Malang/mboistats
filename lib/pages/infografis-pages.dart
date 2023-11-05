import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Infografis {
  final String gambarInfografis;

  Infografis({required this.gambarInfografis});

  factory Infografis.fromJson(Map<String, dynamic> json) {
    return Infografis(
      gambarInfografis: json['gambarInfografis'],
    );
  }
}



class InfografisPages extends StatefulWidget {
  @override
  _InfografisPagesState createState() => _InfografisPagesState();
}

class _InfografisPagesState extends State<InfografisPages> {
  // Deklarasikan variabel untuk menyimpan data infografis dari API
  List<Infografis> infografisData = [];

  @override
  void initState() {
    // Panggil fungsi untuk mengambil data infografis dari API di sini
    fetchDataFromAPI();
    super.initState();
  }

  void fetchDataFromAPI() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://webapi.bps.go.id/v1/api/list/domain/3573/model/infographic/lang/ind/domain/3573/key/9db89e91c3c142df678e65a78c4e547f'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          infografisData = List<Infografis>.from(
              data['data'].map((data) => Infografis.fromJson(data)));
        });
      } else {
        print('HTTP error ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infografis'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 16.0),
              child: Text(
                'INFOGRAFIS TERBARU',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                ),
                itemCount: infografisData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                    child: Image.network(
                      infografisData[index].gambarInfografis,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


