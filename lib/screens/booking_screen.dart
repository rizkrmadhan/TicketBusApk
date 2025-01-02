import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'available_screen.dart'; // Pastikan impor ini benar
import 'package:tiket/controller/pemesanan.dart';
import 'package:tiket/controller/category.dart';

class BusTicketBookingPage extends StatefulWidget {
  @override
  _BusTicketBookingPageState createState() => _BusTicketBookingPageState();
}

class _BusTicketBookingPageState extends State<BusTicketBookingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _startRouteController = TextEditingController();
  final TextEditingController _endRouteController = TextEditingController();
  final TextEditingController _departureDateController =
      TextEditingController();
  DateTime _departureDate = DateTime.now();
  final double _vipPrice = 100.0; // Contoh harga untuk kategori VIP
  final double _economyPrice = 50.0; // Contoh harga untuk kategori Ekonomi
  final pesananController = Get.put(PesananController());
  final categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    _categoryController.text = 'VIP';
    _startRouteController.text = 'Kreng Geukuh';
    _endRouteController.text = 'Lhokseumawe';
    _departureDateController.text = _departureDate.toString().split(' ')[0];
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _startRouteController.dispose();
    _endRouteController.dispose();
    _departureDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Tiket Bus'),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Pilih Category',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10), // Tambahkan jarak antar elemen
                        TextFormField(
                          controller: _categoryController,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a category';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10), // Tambahkan jarak antar elemen
                        TextFormField(
                          controller: _startRouteController,
                          decoration: InputDecoration(
                            labelText: 'Rute Awal',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a start route';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10), // Tambahkan jarak antar elemen
                        TextFormField(
                          controller: _endRouteController,
                          decoration: InputDecoration(
                            labelText: 'Rute Akhir',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an end route';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10), // Tambahkan jarak antar elemen
                        TextFormField(
                          controller: _departureDateController,
                          decoration: InputDecoration(
                            labelText: 'Waktu Berangkat',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          readOnly: true,
                          onTap: () async {
                            final newDate = await showDatePicker(
                              context: context,
                              initialDate: _departureDate,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (newDate != null) {
                              setState(() {
                                _departureDate = newDate;
                                _departureDateController.text =
                                    newDate.toString().split(' ')[0];
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a departure date';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20), // Tambahkan jarak antar elemen
                        ElevatedButton(
                          onPressed: () {
                            categoryController.show();
                            pesananController.store(
                                _categoryController.text.trim(),
                                _startRouteController.text.trim(),
                                _endRouteController.text.trim(),
                                _departureDate);
                            if (_formKey.currentState!.validate()) {
                              double seatPrice =
                                  _categoryController.text == 'VIP'
                                      ? _vipPrice
                                      : _economyPrice;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckAvailabilityPage(
                                    category: _categoryController.text,
                                    startRoute: _startRouteController.text,
                                    endRoute: _endRouteController.text,
                                    departureDate: _departureDate,
                                    seatPrice:
                                        seatPrice, // Tambahkan harga kursi
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text('Cari Tiket'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white, // Text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
