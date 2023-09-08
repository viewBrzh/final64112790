import 'package:Final6411790/assets/dataKeeper.dart';
import 'package:Final6411790/screen/bookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Final6411790/apiEndpoint/apiUrl.dart';
import 'package:Final6411790/assets/allClass.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {

  const EditPage({super.key});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<Booking> listBooking = [];

  @override
  void initState() {
    super.initState();
    getBooking(currentUser.uID);
  }

  Future<void> getBooking(int uID) async {
    try {
      final response = await http.post(Uri.parse('${apiUrl}getBooking.php'),
        body: {
        'uID': uID.toString(),
        },
      );
      print(response.body); // Update the API endpoint.
      if (response.statusCode == 200) {
        final List<dynamic> bookingData = json.decode(response.body);
        List<Booking> bookings = bookingData.map((item) => Booking.fromJson(item)).toList();
        setState(() {
          listBooking = bookings;
        });
      } else {
        throw Exception('Failed to fetch bookings'); // Correct the error message.
      }
    } catch (e) {
      // Handle network or JSON parsing errors here.
      print('Error: $e');
    }
  }

  Future<void> deleteBooking(int bID) async {
    try {
      final response = await http.post(Uri.parse('${apiUrl}deleteBooking.php'),
        body: {
        'bID': bID.toString(),
        },
      ); // Update the API endpoint.
      if (response.statusCode == 200) {
        getBooking(currentUser.uID);
        
      } else {
        throw Exception('Failed to fetch bookings'); // Correct the error message.
      }
    } catch (e) {
      // Handle network or JSON parsing errors here.
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Booking"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listBooking.length,
                itemBuilder: (BuildContext context, int index) {
                  Booking booking = listBooking[index];
                  String formattedDateFrom = DateFormat('dd/MM/yy').format(booking.uDateFrom);
                  String formattedDateTo = DateFormat('dd/MM/yy').format(booking.uDateTo);
                  int carId = booking.cID;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.grey[200],
                    elevation: 0.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Row(children:[Text('Car id: $carId')]),
                        subtitle: Text(
                          'Date: $formattedDateFrom - $formattedDateTo',
                          style: TextStyle(
                            color: Color(0xFFE5750E),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit_calendar),
                              onPressed: () {
                                currentBook = booking.bID;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen()));
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteBooking(booking.bID);
                              },
                            ),
                          ],
                        ),
                        
                      ),
                    ),
                  );
                },
              ),

            ),
          ),
        ],
      ),
    );
  }
}
