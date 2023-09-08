import 'package:Final6411790/screen/catalogsScreen.dart';
import 'package:Final6411790/screen/aboutScreen.dart';
import 'package:Final6411790/screen/bookingScreen.dart';
import 'package:Final6411790/screen/editScreen.dart';
import 'package:Final6411790/screen/SignInScreen.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking App"),
      ),
      body: Column(
        children: [
          SizedBox(height: 200,),
          Center(
            child: Text("Welcome",
              style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueAccent
              ),
            ),
          ),
          SizedBox(height: 46,),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(context , MaterialPageRoute(builder: (context) => SignIn())), 
            icon: Icon(Icons.login), 
            label: Text("Login"),
          ),
          SizedBox(height: 16,),
          Row(
            children: <Widget>[
                const Text('Access without logging in'),
                TextButton(
                  child: const Text(
                    'Click!',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CatalogsPage(),
                    )
                  );
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          SizedBox(height: 200,),
          Center(
            child: Text('List Screen'),
          ),
          SizedBox(height: 16,),
          Row(
            children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Handle booking button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatalogsPage(),
                      ),
                    );
                  }, 
                  child: Text('Catalogs')
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle booking button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingScreen(),
                      ),
                    );
                  }, 
                  child: Text('Booking')
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle booking button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPage(),
                      ),
                    );
                  }, 
                  child: Text('Edit')
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle booking button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutScreen(),
                      ),
                    );
                  }, 
                  child: Text('About')
                ),
          
              ],
              mainAxisAlignment: MainAxisAlignment.center,
          ),  
        ]
          
      ),
      
    );
  }
}