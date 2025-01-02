import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Digunakan untuk formatting tanggal

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicketPurchasePage(
        ticket: Ticket(
          id: 'TKT123456',
          departureLocation: 'Jakarta',
          arrivalLocation: 'Bandung',
          departureTime: DateTime.now(),
          seatNumber: 'A3',
          price: 75000,
        ),
      ),
    );
  }
}

class TicketPurchasePage extends StatelessWidget {
  final Ticket ticket;

  TicketPurchasePage({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bukti Pembelian Tiket'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(31, 229, 255, 1),
              Color.fromARGB(255, 29, 57, 235)
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID Tiket: ${ticket.id}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
                'Keberangkatan: ${ticket.departureLocation} - ${ticket.arrivalLocation}'),
            Text(
                'Waktu Keberangkatan: ${DateFormat('dd MMMM yyyy HH:mm').format(ticket.departureTime)}'),
            Text('Nomor Kursi: ${ticket.seatNumber}'),
            SizedBox(height: 20),
            Text(
              'Harga: Rp ${ticket.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Menggunakan FutureBuilder untuk menunggu beberapa detik sebelum kembali ke dashboard
            FutureBuilder(
              future: Future.delayed(Duration(seconds: 3)), // Tunggu 3 detik
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Navigasi kembali ke halaman dashboard setelah selesai menunggu
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    Navigator.pop(context);
                  });
                }
                // Tampilkan indikator progress atau widget lainnya selama menunggu
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Ticket {
  final String id;
  final String departureLocation;
  final String arrivalLocation;
  final DateTime departureTime;
  final String seatNumber;
  final double price;

  Ticket({
    required this.id,
    required this.departureLocation,
    required this.arrivalLocation,
    required this.departureTime,
    required this.seatNumber,
    required this.price,
  });
}
