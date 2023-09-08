import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'SignInScreen.dart';
import 'package:Final6411790/apiEndpoint/apiUrl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController cPassController = TextEditingController();

 Future<void> _regiseter(String tel, String pass, String username, String cPass) async {
  final response = await http.post(
    Uri.parse('${apiUrl}register.php'),
    body: {
      'uTelephone': tel,
      'uPassword': pass,
      'uName': username,
      'cPassword': cPass
    },
  );
  print("Response: ${response.body}");

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);

    if (responseData['success'] == true) {
      

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignIn(),
        ),
      );
      } else {
        if (responseData.containsKey('message')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${responseData['message']}"),
            ),
          );
        }
        
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Register',
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
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  labelText: 'Username',
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
              padding: const EdgeInsets.all(10),
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
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: cPassController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  labelText: 'Confirm Password',
                ),
              ),
            ),
            SizedBox(height: 16,),
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
                  'Submit',
                  style: TextStyle(
                    color: Color.fromARGB(255, 249, 248, 247), // Color for the text (229, 117, 14)
                  ),
                ),
                
                onPressed: () {
                  final String tel = telephoneController.text;
                  final String password = passwordController.text;
                  final String username = usernameController.text;
                  final String cPass = cPassController.text;
                  _regiseter(tel, password, username, cPass);
                },
              ),
            ),
          ]
        )
      )
    );
  }
}