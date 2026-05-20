import 'package:flutter/material.dart';

import '../dashboard/dashboard_screen.dart';
import '../jadwal/jadwal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int selectedIndex = 0;

  void changeTab(int index) {

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [

      DashboardScreen(
        onTabChange: changeTab,
      ),

      const JadwalScreen(),
    ];

    return Scaffold(

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: selectedIndex,

        selectedItemColor: const Color(0xFF1A58B7),
        unselectedItemColor: Colors.grey,

        onTap: (index) {

          setState(() {
            selectedIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Jadwal',
          ),
        ],
      ),
    );
  }
}