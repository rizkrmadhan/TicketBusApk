import 'package:flutter/material.dart';

class BackToBookingPage extends StatelessWidget {
  final String category;
  final String startRoute;
  final String endRoute;
  final DateTime departureDate;

  BackToBookingPage({
    required this.category,
    required this.startRoute,
    required this.endRoute,
    required this.departureDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kembali ke Pemesanan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kategori Bus: $category'),
            Text('Rute Awal: $startRoute'),
            Text('Rute Akhir: $endRoute'),
            Text(
                'Tanggal Berangkat: ${departureDate.toString().split(' ')[0]}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
