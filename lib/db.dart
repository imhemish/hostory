import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostory/items.dart';

class RoomDetails {
  final List<String> residents;
  final Map<String, int> counts;
  const RoomDetails(this.residents, this.counts);
}

class Database {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch the last room number
  static Future<int> getLastRoom() async {
    var snapshot = await _firestore.collection('rooms').orderBy('roomNumber', descending: true).limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data()['roomNumber'] as int;
    }
    return 0; // Return 0 if no rooms exist yet
  }

  // Add a room with two residents
  static Future<(bool, String?)> addRoom(int roomNumber, String resident1, String resident2) async {
    try {
      await _firestore.collection('rooms').doc(roomNumber.toString()).set({
        'roomNumber': roomNumber,
        'residents': [resident1, resident2],
        'items': { for (var name in items) name: 0 }, // Default item counts
      });
      return (true, null);
    } catch (e) {
      return (false, e.toString());
    }
  }

  // Increase the count of an item in the store
  static Future<(bool, String?)> increaseStoreItem(String item, int increaseAmount) async {
    try {
      var docRef = _firestore.collection('store').doc('inventory');
      var snapshot = await docRef.get();
      var currentCount = snapshot.data()?[item] ?? 0;
      await docRef.update({item: currentCount + increaseAmount});
      return (true, null);
    } catch (e) {
      return (false, e.toString());
    }
  }

  // Decrease the count of an item in the store
  static Future<(bool, String?)> decreaseStoreItem(String item, int decreaseAmount) async {
    try {
      var docRef = _firestore.collection('store').doc('inventory');
      var snapshot = await docRef.get();
      var currentCount = snapshot.data()?[item] ?? 0;
      if (currentCount >= decreaseAmount) {
        await docRef.update({item: currentCount - decreaseAmount});
        return (true, null);
      } else {
        return (false, 'Insufficient stock');
      }
    } catch (e) {
      return (false, e.toString());
    }
  }

  // Get details of a specific room
  static Future<(RoomDetails?, String?)> getRoomDetails(int roomNumber) async {
    try {
      var snapshot = await _firestore.collection('rooms').doc(roomNumber.toString()).get();
      if (snapshot.exists) {
        var data = snapshot.data()!;
        List<String> residents = List<String>.from(data['residents']);
        Map<String, int> counts = Map<String, int>.from(data['items']);
        return (RoomDetails(residents, counts), null);
      }
      return (null, 'Room not found');
    } catch (e) {
      return (null, e.toString());
    }
  }

  // Get details of the store
  static Future<(RoomDetails?, String?)> getStoreDetails() async {
    try {
      var snapshot = await _firestore.collection('store').doc('inventory').get();
      if (snapshot.exists) {
        Map<String, int> counts = Map<String, int>.from(snapshot.data()!);
        return (RoomDetails([], counts), null); // No residents for store
      } else {
        await _firestore.collection('store').doc('inventory').set({
          for (int i = 0; i < items.length; i++) items[i]:0
        });
        return (RoomDetails([], {
          for (int i = 0; i < items.length; i++) items[i]:0
        }), null);
        
      }
    } catch (e) {
      return (null, e.toString());
    }
  }

  // Set the item count in a specific room and update the store
  static Future<(bool, String?)> setRoomItem(int roomNumber, String item, int oldNumber, int newNumber) async {
    if (oldNumber == newNumber) {
      return (true, null);
    }

    late (bool, String?) storeResult;

    if (oldNumber > newNumber) {
      storeResult = await increaseStoreItem(item, oldNumber - newNumber);
    } else {
      storeResult = await decreaseStoreItem(item, newNumber - oldNumber);
    }

    if (storeResult.$1) {
      try {
        var roomDoc = _firestore.collection('rooms').doc(roomNumber.toString());
        var roomSnapshot = await roomDoc.get();
        if (roomSnapshot.exists) {
          await roomDoc.update({'items.$item': newNumber});
          return (true, null);
        } else {
          return (false, 'Room not found');
        }
      } catch (e) {
        return (false, e.toString());
      }
    } else {
      return (false, storeResult.$2);
    }
  }

  static Future<(bool, String?)> deleteRoom(int roomNumber) async {
    try {
      // Query the room by roomNumber and delete the document
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('rooms')
          .where('roomNumber', isEqualTo: roomNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return (false, 'Room not found');
      }

      // Get the document ID and delete the document
      String docId = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance.collection('rooms').doc(docId).delete();
      
      return (true, null);
    } catch (e) {
      print('Error deleting room: $e');
      return (false, 'Failed to delete room');
    }
  }
}
