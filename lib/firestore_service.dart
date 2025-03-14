import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection('BookingTickets');

  Future<void> addBooking(String movieName, String theaterId, String seatNumber) {
    return bookings.add({
      'movieName': movieName,
      'theaterId': theaterId,
      'seatNumber': seatNumber,
    });
  }

  Stream<QuerySnapshot> getBookings() {
    return bookings.snapshots();
  }

  Future<void> updateBooking(String id, String theaterId, String seatNumber) {
    return bookings.doc(id).update({
      'theaterId': theaterId,
      'seatNumber': seatNumber,
    });
  }

  Future<void> deleteBooking(String id) {
    return bookings.doc(id).delete();
  }
}
