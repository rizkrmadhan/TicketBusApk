import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class SeatSelectionPage extends StatefulWidget {
  final String category;
  final String startRoute;
  final String endRoute;
  final DateTime departureDate;
  final String? seatNumber;
  final double seatPrice;

  SeatSelectionPage({
    required this.category,
    required this.startRoute,
    required this.endRoute,
    required this.departureDate,
    required this.seatNumber,
    this.seatPrice = 0.0,
  });

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  final List<int> _reservedSeats = [2, 5, 8]; // Example of reserved seats

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kursi'),
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
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 20, // Assume there are 20 seats
                itemBuilder: (context, index) {
                  bool isReserved = _reservedSeats.contains(index + 1);
                  bool isSelected = widget.seatNumber == (index + 1).toString();
                  return ElevatedButton(
                    onPressed: isReserved
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                  category: widget.category,
                                  startRoute: widget.startRoute,
                                  endRoute: widget.endRoute,
                                  departureDate: widget.departureDate,
                                  seatNumber: (index + 1).toString(),
                                  seatPrice: widget.seatPrice,
                                ),
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isReserved
                          ? const Color.fromARGB(255, 185, 22, 11)
                          : isSelected
                              ? const Color.fromARGB(255, 29, 57, 235)
                              : const Color.fromARGB(255, 250, 252, 253),
                    ),
                    child: isReserved
                        ? Icon(Icons.close)
                        : isSelected
                            ? Icon(Icons
                                .close) // Mengganti dengan ikon silang ketika kursi sudah dipilih
                            : Text('Kursi ${index + 1}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
