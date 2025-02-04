import 'package:flutter/material.dart';
import '../models/banda_model.dart';

class DetalhesBandaScreen extends StatelessWidget {
  final Banda banda;

  DetalhesBandaScreen({required this.banda});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(banda.nome),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.blue,
              child: Text(
                banda.nome.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              banda.nome,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              banda.genero,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16.0),
            Text(
              banda.descricao,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}