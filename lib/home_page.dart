import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity, // Takes up the entire width
      height: double.infinity, // Takes up the entire height
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 147, 211, 129),
            Color.fromARGB(255, 82, 179, 98),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 25.0),
        child: Text(
          "Welcome User!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    ));
  }
}
