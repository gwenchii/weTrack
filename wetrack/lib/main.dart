import 'package:flutter/material.dart';
import '../app/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash, // Set the initial route
      onGenerateRoute: AppRoutes.generateRoute, // Use the route generator
    );
  }
}
