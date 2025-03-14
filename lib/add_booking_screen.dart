import 'package:flutter/material.dart';
import 'firestore_service.dart';

class AddBookingScreen extends StatefulWidget {
  @override
  _AddBookingScreenState createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController movieController = TextEditingController();
  final TextEditingController theaterController = TextEditingController();
  final TextEditingController seatController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เพิ่มการจองตั๋ว")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: movieController,
                decoration: InputDecoration(labelText: "ชื่อภาพยนตร์"),
                validator: (value) => value!.isEmpty ? "กรุณากรอกชื่อภาพยนตร์" : null,
              ),
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
                    await firestoreService.addBooking(
                      movieController.text,
                      theaterController.text,
                      seatController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text("บันทึก"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
