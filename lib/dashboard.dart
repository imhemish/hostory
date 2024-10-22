import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'items.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            
            children: [
              // Total Rooms
              _buildTotalRoomsCard(),
              SizedBox(height: 20),
              // Total Items Deployed across all rooms
              _buildTotalItemsDeployedCard(),
            ],
          ),
        ),
      ),
    );
  }

  // Card for displaying total number of rooms from Firestore
  Widget _buildTotalRoomsCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          
          children: [
            Text('Total Rooms', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading...');
                }
                int totalRooms = snapshot.data!.docs.length;
                return Text('$totalRooms', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
              },
            ),
          ],
        ),
      ),
    );
  }

  // Card for displaying total number of items deployed across rooms
  Widget _buildTotalItemsDeployedCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Total Items', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('rooms').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading...');
                }
                
                // Initialize total item count to 0
                int totalItemsDeployed = 0;

                // Iterate through each room document
                snapshot.data!.docs.forEach((doc) {
                  // Extract the room details
                  Map<String, dynamic> roomData = doc.data() as Map<String, dynamic>;

                  // Add the count of each item from the room
                  items.forEach((item) {
                    if (roomData['items'] != null && roomData['items'][item] != null) {
                      totalItemsDeployed += roomData['items'][item] as int;
                    }
                  });
                });

                return Text('$totalItemsDeployed', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
              },
            ),
          ],
        ),
      ),
    );
  }
}
