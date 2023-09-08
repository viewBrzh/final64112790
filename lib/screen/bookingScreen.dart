import 'package:Final6411790/screen/Catalogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Final6411790/apiEndpoint/apiUrl.dart';
import 'package:Final6411790/assets/allClass.dart';
import 'package:Final6411790/assets/dataKeeper.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Booking? currentBooking; 
  String alert = '';
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(DateTime.now().month + 5),
      initialDateRange: fromDate != null && toDate != null
          ? DateTimeRange(start: fromDate!, end: toDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        fromDate = picked.start;
        toDate = picked.end;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> bookCar(int carId, DateTime fromDate, DateTime toDate) async {
  final response = await http.post(
    Uri.parse('${apiUrl}insertBooking.php'),
    body: {
      'cID': carId.toString(),
      'uID': currentUser.uID.toString(),
      'from_date': fromDate.toUtc().toIso8601String(),
      'to_date': toDate.toUtc().toIso8601String(),
    },
  );
  final responseData = json.decode(response.body);
  alert = responseData['message'];
  print(alert);
  if (response.statusCode == 200) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CatalogsPage()));
  } else {
    print("Insert Booking fails");
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Booking"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Booking Date Range:",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDateRange(context),
                child: Text(
                  "${fromDate?.toLocal() ?? 'Start Date'} - ${toDate?.toLocal() ?? 'End Date'}",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16,),
              ElevatedButton.icon(
                onPressed: () {
                  if (fromDate != null && toDate != null) {
                    bookCar(currentCar, fromDate!, toDate!);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Booking Status"),
                          content: Text(alert), // Display your alert message here
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Please select a date range."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                icon: Icon(Icons.save_as_sharp),
                label: Text("Save"),
              )
            ],
          ),
        ),
      ),
      
    );
  }
}

