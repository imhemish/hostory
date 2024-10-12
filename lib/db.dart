import 'package:hostory/items.dart';

class RoomDetails {
  final List<String> residents;
  final Map<String, int> counts;
  const RoomDetails(this.residents, this.counts);
}

class Database {

  static Future<int> getLastRoom() async {
    return 20;
    // do some db stuff here
  }

  static Future<(bool, String?)> addRoom(int roomNumber, String resident1, String resident2) async {
    return (true, null) ;
    // do some db stuff here
  }

  static Future<(bool, String?)> increaseStoreItem(int roomNumber, String item, int increaseAmount) async {
    print("Store: ${item} is increased by ${increaseAmount}");
    return (true, null);
    // do some db stuff here
  }

  static Future<(bool, String?)> decreaseStoreItem(int roomNumber, String item, int decreaseAmount) async {
    print("Store: ${item} is decreased by ${decreaseAmount}");
    return (true, null);
    // do some db stuff here
  }

  static Future<(RoomDetails?, String?)> getRoomDetails(int roomNumber) async {
    // do some db stuff here
    return (RoomDetails(["Hemish", "Akul"], 
    { for (var name in items) name : 1 }
    ), null);
  }

  static Future<(bool, String?)> setRoomItem(int roomNumber, String item, int oldNumber, int newNumber) async {
    if (oldNumber == newNumber) {
      return (true, null);
    }

    late (bool, String?) storeResult;

    if (oldNumber > newNumber) {
      storeResult = await increaseStoreItem(roomNumber, item, oldNumber - newNumber);
    } else {
      storeResult = await decreaseStoreItem(roomNumber, item, newNumber - oldNumber);
    }

    if (storeResult.$1) {
      late (bool, String?) roomResult;
      // Do some db stuff here
      print("Room: ${item} changed to ${newNumber}");
      roomResult = (true, null);
      // ends here

      if (roomResult.$1) {
        return (true, null);
      } else {
        return (false, roomResult.$2);
      }
    } else {
      return (false, storeResult.$2);
    }
  }

}