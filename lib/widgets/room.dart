import 'package:flutter/material.dart';
import 'package:hostory/individual_room.dart';

class Room extends StatelessWidget {
  final int number;
  Room(this.number);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => IndividualRoomPage(number))),
      child: Stack(
        children: [
          Image.asset("assets/room.png"),
          Positioned(
            top: 50, // Adjust as needed
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  " ${number.toString()} ",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
