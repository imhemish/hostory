import 'package:flutter/material.dart';
import 'package:hostory/individual_room.dart';

double calculateLeft(double width) {
  return ((width - 16) / ((width - 16) ~/ 200)) /2;
}

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
          Image.asset("room.png"),
          Positioned(
            top: 40,
            left: calculateLeft(MediaQuery.sizeOf(context).width),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple, // Set color here
                
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(" ${number.toString()} ", style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}
