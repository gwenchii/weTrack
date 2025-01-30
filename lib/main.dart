import 'package:flutter/material.dart';
import '../app/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash, // Set the initial route
      onGenerateRoute: AppRoutes.generateRoute, // Use the route generator
      theme: ThemeData(
        fontFamily: 'Fredoka', // Apply Fredoka font globally
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Fredoka'),
          bodyMedium: TextStyle(fontFamily: 'Fredoka'),
          displayLarge: TextStyle(fontFamily: 'Fredoka'),
          displayMedium: TextStyle(fontFamily: 'Fredoka'),
        ),
      ),
    );
  }
}
