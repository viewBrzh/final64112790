import 'package:Final6411790/screen/Catalogs.dart';
import 'package:flutter/material.dart';
import 'package:Final6411790/screen/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Final6411790/apiEndpoint/apiUrl.dart';
import 'package:Final6411790/assets/dataKeeper.dart';
import 'package:Final6411790/assets/allClass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int counter = 0;

  Future<void> _login(String tel, String pass) async {
    final response = await http.post(
      Uri.parse('${apiUrl}login.php'),
      body: {
        'uTelephone': tel,
        'uPassword': pass,
      },
    );
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['success'] == true) {
        int userId = 0;
        String userTelephone = "";
        String userName ="";

        // Check if the 'id', 'uTelephone', and 'uName' fields exist in the response
        if (responseData.containsKey('id')) {
          userId = responseData['id'];
        }
        if (responseData.containsKey('telephone')) {
          userTelephone = responseData['telephone'];
        }
        if (responseData.containsKey('name')) {
          userName = responseData['name'];
        }

        // Show the userId, userTelephone, and userName
        print("User ID: $userId");
        print("User Telephone: $userTelephone");
        print("User Name: $userName");

        setState(() {
          // Update the UI or set user-related variables if needed
          currentUser = User(name: userName,uID: userId, uTelephone: userTelephone);
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CatalogsPage(),
          ),
        );
      } else {
        counter++;
          // Login failed, show an error message or handle as needed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message']),
            ),
          );
        }
      } else {
        // HTTP request failed, show an error message or handle as needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An error occurred. Please try again later."),
          ),
        );
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 100),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Welcome back',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueAccent
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: telephoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  labelText: 'Telephone Numbers',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 8,),
            Center(child:Text('input error: ${counter}'),),
            SizedBox(height: 8,),
            Center(          
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(90, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0), // Adjust the radius as needed
                    ),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color.fromARGB(255, 249, 248, 247), // Color for the text (229, 117, 14)
                  ),
                ),
                
                onPressed: () {
                  final String tel = telephoneController.text;
                  final String password = passwordController.text;
                  _login(tel, password);
                },
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Does not have an account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    )
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ]
        )
      )
    );
  }
}