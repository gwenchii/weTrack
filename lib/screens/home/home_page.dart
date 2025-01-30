import 'package:flutter/material.dart';
import 'package:wetrack/widgets/navigation_bar.dart';
import 'package:wetrack/screens/home/dashboard_page.dart'; // Import your actual screens here
import 'package:wetrack/screens/loan/createborrower_page.dart';
import 'package:wetrack/screens/profile/userprofile_page.dart';
import 'package:wetrack/screens/calculator/compound_interest.dart'; // Calculator screen import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index

  // Define a function to navigate to the screens
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    switch (index) {
      case 0:
        // Home Page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        // Dashboard
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
        break;
      case 2:
        // Calculator
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CompoundInterest()),
        );
        break;
      case 3:
        // Create Borrower Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateBorrowerPage()),
        );
        break;
      case 4:
        // Profile Page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
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
          ),
          // Overlay Text
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 25.0),
            child: Text(
              "Welcome User!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex, // Pass the current index to the navigation bar
        onTap: _onItemTapped, // Handle tab tap and navigate to corresponding screen
      ),
    );
  }
}
