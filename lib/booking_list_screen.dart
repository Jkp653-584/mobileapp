import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_service.dart';
import 'add_booking_screen.dart';
import 'edit_booking_screen.dart';

class BookingListScreen extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายการจองตั๋ว")),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getBookings(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text("เกิดข้อผิดพลาด"));
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              var booking = bookings[index];
              return ListTile(
                title: Text(booking['movieName']),
                subtitle: Text("โรง: ${booking['theaterId']} ที่นั่ง: ${booking['seatNumber']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditBookingScreen(
                              docId: booking.id,
                              theaterId: booking['theaterId'],
                              seatNumber: booking['seatNumber'],
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => firestoreService.deleteBooking(booking.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookingScreen()),
          );
        },
      ),
    );
  }
}
