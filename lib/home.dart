import 'package:flutter/material.dart';
import 'package:hostory/dashboard.dart';
import 'package:hostory/rooms.dart';
import 'package:hostory/store.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> pages = [Rooms(), Dashboard(), Store()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: 
      const [
        BottomNavigationBarItem(icon: Icon(Icons.room), label: "Rooms"),
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store")
      ],
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() {
        _selectedIndex = index;
      }),
      ),
      body: pages[_selectedIndex],
    );
  }
}