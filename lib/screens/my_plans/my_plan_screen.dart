import 'package:flutter/material.dart';

class MyPlansScreen extends StatefulWidget {
  const MyPlansScreen({super.key});

  @override
  _MyPlansScreenState createState() => _MyPlansScreenState();
}
class _MyPlansScreenState extends State<MyPlansScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Gym Book"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "My Plans page",
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
    );
  }
}