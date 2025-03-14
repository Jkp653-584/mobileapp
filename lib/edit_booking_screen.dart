import 'package:flutter/material.dart';
import 'firestore_service.dart';

class EditBookingScreen extends StatefulWidget {
  final String docId;
  final String theaterId;
  final String seatNumber;

  EditBookingScreen({required this.docId, required this.theaterId, required this.seatNumber});

  @override
  _EditBookingScreenState createState() => _EditBookingScreenState();
}

class _EditBookingScreenState extends State<EditBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController theaterController = TextEditingController();
  final TextEditingController seatController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    theaterController.text = widget.theaterId;
    seatController.text = widget.seatNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("แก้ไขการจองตั๋ว")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: theaterController,
                decoration: InputDecoration(labelText: "รหัสโรงภาพยนตร์"),
                validator: (value) => value!.isEmpty ? "กรุณากรอกรหัสโรงภาพยนตร์" : null,
              ),
              TextFormField(
                controller: seatController,
                decoration: InputDecoration(labelText: "หมายเลขที่นั่ง"),
                validator: (value) => value!.isEmpty ? "กรุณากรอกหมายเลขที่นั่ง" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await firestoreService.updateBooking(
                      widget.docId,
                      theaterController.text,
                      seatController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text("บันทึกการเปลี่ยนแปลง"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
