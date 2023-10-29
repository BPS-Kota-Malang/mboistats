import 'package:flutter/material.dart';

class ButtonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: 8.0, left: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildButton(context, "Berita Resmi Statistik", Colors.blue,
                '/berita_resmi'),
            SizedBox(width: 16.0),
            _buildButton(context, "Infografis", Colors.blue, '/infografis'),
            SizedBox(width: 16.0),
            _buildButton(context, "Tentang Kami", Colors.blue, '/tentang_kami'),
            SizedBox(width: 16.0),
            _buildButton(context, "Lainnya", Colors.blue, '/lainnya'),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, Color color, String routeName) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
            context, '/berita'); // Pindah ke halaman dengan rute yang sesuai
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
