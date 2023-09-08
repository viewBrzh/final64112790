import 'package:Final6411790/screen/homeScreen.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("About Me"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Image(
                image: const AssetImage('lib/assets/image/about.jpg'),
                width: 150,
                height: 150,
              ),
              SizedBox(height: 16,),
              Text(
                '64112790',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 8,),
              Text('Watayut Pankong'),
              SizedBox(height: 16,),
              Text(
                'Tel. 0626483486',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 28,),
              ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())), child: Text('Home Screen'))
            ],
          ),
        ),
      ),
    );
  }
}