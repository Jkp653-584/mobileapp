import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firestore_service.dart';
import 'booking_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Ticket Booking',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BookingListScreen(),
    );
  }
}