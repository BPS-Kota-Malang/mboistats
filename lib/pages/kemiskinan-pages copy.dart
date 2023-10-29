// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class KemiskinanPages extends StatefulWidget {
//   @override
//   _KemiskinanPagesState createState() => _KemiskinanPagesState();
// }

// class _KemiskinanPagesState extends State<KemiskinanPages> {
//   List<Map<String, dynamic>> data = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final uri = Uri.parse('https://webapi.bps.go.id/v1/api/list/model/data/domain/3573/var/432/key/9db89e91c3c142df678e65a78c4e547f');
//     final response = await http.get(uri);

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);

//       final tahun = responseData['tahun'];
//       final datacontent = responseData['datacontent'];

//       for (var i = 0; i < tahun.length; i++) {
//         final year = tahun[i]['label'];
//         final yearInt = int.parse(year);

//         // Hanya tahun 2015 ke atas
//         if (yearInt >= 2015) {
//           final kotaMalang = datacontent['14320${tahun[i]['val']}0'] ?? 0.0;
//           final jawaTimur = datacontent['24320${tahun[i]['val']}0'] ?? 0.0;
//           final indonesia = datacontent['34320${tahun[i]['val']}0'] ?? 0.0;

//           data.add({
//             'Tahun': year,
//             'Kota Malang': kotaMalang,
//             'Jawa Timur': jawaTimur,
//             'Indonesia': indonesia,
//           });
//         }
//       }

//       setState(() {
//         isLoading = false;
//       });
//     } else {
//       throw Exception('Failed to load data from API');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kemiskinan Pages'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: DataTable(
//                 columnSpacing: 24.0, // Mengatur jarak antar kolom
//                 columns: [
//                   DataColumn(label: Text('Tahun')),
//                   DataColumn(label: Text('Kota Malang')),
//                   DataColumn(label: Text('Jawa Timur')),
//                   DataColumn(label: Text('Indonesia')),
//                 ],
//                 rows: data
//                     .map(
//                       (item) => DataRow(
//                         cells: [
//                           DataCell(Text(item['Tahun'])),
//                           DataCell(Text(item['Kota Malang'].toString())),
//                           DataCell(Text(item['Jawa Timur'].toString())),
//                           DataCell(Text(item['Indonesia'].toString())),
//                         ],
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//     );
//   }
// }
