import 'package:flutter/material.dart';
import 'package:hostory/db.dart';
import 'package:hostory/widgets/room.dart';
import './add_room.dart';

class Rooms extends StatefulWidget {
  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  bool loading = true;
  int numberOfRooms = 0;
  String searchQuery = ""; // Search query to filter rooms
  TextEditingController searchController = TextEditingController(); // Controller for search input

  @override
  void initState() {
    loading = true;
    _loadNumberOfRooms();
    super.initState();
  }

  Future<void> _loadNumberOfRooms() async {
    numberOfRooms = await Database.getLastRoom();
    setState(() {
      loading = false;
    });
  }

  // Filter the rooms based on the search query
  List<int> _filteredRooms() {
    if (searchQuery.isEmpty) {
      return List.generate(numberOfRooms, (index) => index + 1); // Show all rooms
    } else {
      return List.generate(numberOfRooms, (index) => index + 1)
          .where((roomNumber) => roomNumber.toString().contains(searchQuery))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading == false) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Rooms'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search by room number',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value; // Update search query on text change
                  });
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddRoomPage()));
          },
          child: Icon(Icons.add),
        ),
        body: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final filteredRooms = _filteredRooms(); // Get filtered rooms
            return Room(filteredRooms[index]);
          },
          itemCount: _filteredRooms().length, // Set itemCount to the number of filtered rooms
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator.adaptive());
    }
  }
}
