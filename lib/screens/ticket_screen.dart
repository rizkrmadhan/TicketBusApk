import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart'; // Digunakan untuk formatting tanggal

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicketPage(),
    );
  }
}

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  String _ticketInfo = "";
  Ticket? _ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran Tiket'),
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
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nama Lengkap'),
              onChanged: (value) {
                setState(() {
                  _ticketInfo = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showPaymentDialog(context);
              },
              child: Text('Bayar Tiket'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembayaran'),
          content: Text('Apakah Anda yakin ingin membayar tiket?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _generateTicketPdf();
              },
              child: Text('Bayar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _generateTicketPdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.Text('Nama Pembeli: $_ticketInfo'),
                if (_ticket != null) ...[
                  pw.Text('ID Tiket: ${_ticket!.id}'),
                  pw.Text(
                      'Keberangkatan: ${_ticket!.departureLocation} - ${_ticket!.arrivalLocation}'),
                  pw.Text(
                      'Waktu Keberangkatan: ${DateFormat('dd MMMM yyyy HH:mm').format(_ticket!.departureTime)}'),
                  pw.Text('Nomor Kursi: ${_ticket!.seatNumber}'),
                  pw.Text('Harga: Rp ${_ticket!.price.toStringAsFixed(2)}'),
                ],
              ],
            ),
          );
        },
      ),
    );

    final output = await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
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
