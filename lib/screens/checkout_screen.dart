import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckoutPage(
        category: '',
        startRoute: '',
        endRoute: '',
        departureDate: DateTime.now(),
        seatNumber: '',
        seatPrice: 100000,
      ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  final String category;
  final String startRoute;
  final String endRoute;
  final DateTime departureDate;
  final String seatNumber;
  final double seatPrice;

  CheckoutPage({
    required this.category,
    required this.startRoute,
    required this.endRoute,
    required this.departureDate,
    required this.seatNumber,
    this.seatPrice = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout Tiket'),
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
            Text('Kategori: $category'),
            Text('Rute Mulai: $startRoute'),
            Text('Rute Akhir: $endRoute'),
            Text('Tanggal Keberangkatan: ${departureDate.toLocal()}'),
            Text('Nomor Kursi: $seatNumber'),
            Text('Harga per Kursi: $seatPrice'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketPage(
                      category: category,
                      startRoute: startRoute,
                      endRoute: endRoute,
                      departureDate: departureDate,
                      seatNumber: seatNumber,
                      seatPrice: seatPrice,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    vertical: 30, horizontal: 32), // Ubah sesuai kebutuhan Anda
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Lanjutkan ke Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketPage extends StatefulWidget {
  final String category;
  final String startRoute;
  final String endRoute;
  final DateTime departureDate;
  final String seatNumber;
  final double seatPrice;

  TicketPage({
    required this.category,
    required this.startRoute,
    required this.endRoute,
    required this.departureDate,
    required this.seatNumber,
    required this.seatPrice,
  });

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  String _ticketInfo = "";

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
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text('Nama: $_ticketInfo'),
                pw.Text('Kategori: ${widget.category}'),
                pw.Text('Rute Mulai: ${widget.startRoute}'),
                pw.Text('Rute Akhir: ${widget.endRoute}'),
                pw.Text(
                    'Tanggal Keberangkatan: ${widget.departureDate.toLocal()}'),
                pw.Text('Nomor Kursi: ${widget.seatNumber}'),
                pw.Text('Harga per Kursi: ${widget.seatPrice}'),
              ],
            ),
          );
        },
      ),
    );

    // ignore: unused_local_variable
    final output = await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
