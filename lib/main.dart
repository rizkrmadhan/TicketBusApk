import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/available_screen.dart';
import 'screens/back_to_booking_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/seat_selection_screen.dart';

void main() async {
  // Inisialisasi Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCWROVQbNNPdpQYngyaOQAhqsrow3eBH_w",
      appId: "1:249965296581:android:cd5cb80b8812fc846da9ac",
      messagingSenderId: "249965296581",
      projectId: "tiket-be542",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ticket Bus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => login(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/booking': (context) => BusTicketBookingPage(),
        '/available': (context) => CheckAvailabilityPage(
              category:
                  'VIP', // Berikan nilai default yang bermakna atau kelola keamanan null
              startRoute: 'Kreng Geukuh',
              endRoute: 'Lhokseumawe',
              departureDate: DateTime.now(),
              seatPrice: 0, // Nilai default untuk harga kursi
            ),
        '/back_to_booking': (context) => BackToBookingPage(
              category:
                  'VIP', // Berikan nilai default yang bermakna atau kelola keamanan null
              startRoute: 'Kreng Geukuh',
              endRoute: 'Lhokseumawe',
              departureDate: DateTime.now(),
            ),
        '/checkout': (context) => CheckoutPage(
              category:
                  'VIP', // Berikan nilai default yang bermakna atau kelola keamanan null
              startRoute: 'Kreng Geukuh',
              endRoute: 'Lhokseumawe',
              departureDate: DateTime.now(),
              seatNumber:
                  '1', // Pastikan keamanan null ditangani di CheckoutPage
              seatPrice: 0, // Nilai default untuk harga kursi
            ),
        '/seat_selection': (context) => SeatSelectionPage(
              category:
                  'VIP', // Berikan nilai default yang bermakna atau kelola keamanan null
              startRoute: 'Kreng Geukuh',
              endRoute: 'Lhokseumawe',
              departureDate: DateTime.now(),
              seatNumber: null,
              seatPrice: 0, // Nilai default untuk harga kursi
            ),
      },
    );
  }
}
