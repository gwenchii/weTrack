import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap, // Only keep this
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calculate_rounded),
          label: 'Calculator',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Settings',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap, // Calls the onTap function when an item is tapped
      selectedItemColor: const Color.fromARGB(255, 82, 179, 98),
      unselectedItemColor: Colors.grey,
    );
  }
}
