import 'package:flutter/material.dart';
import 'seat_selection_screen.dart';

class CheckAvailabilityPage extends StatelessWidget {
  final String category;
  final String startRoute;
  final String endRoute;
  final DateTime departureDate;
  final double seatPrice;

  CheckAvailabilityPage({
    required this.category,
    required this.startRoute,
    required this.endRoute,
    required this.departureDate,
    this.seatPrice = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    bool ticketsAvailable = _checkTicketAvailability();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Ketersediaan Tiket'),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Memeriksa ketersediaan tiket...'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (ticketsAvailable) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatSelectionPage(
                          category: category,
                          startRoute: startRoute,
                          endRoute: endRoute,
                          departureDate: departureDate,
                          seatNumber: null,
                          seatPrice: seatPrice,
                        ),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text(ticketsAvailable
                    ? 'Lanjut ke Pemilihan Kursi'
                    : 'Kembali ke Pemesanan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _checkTicketAvailability() {
    // Simulate checking ticket availability
    return DateTime.now().second % 2 == 0;
  }
}
