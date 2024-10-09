import 'package:flutter/material.dart';
import 'package:hostory/items.dart';


class IndividualRoomPage extends StatefulWidget {
  final int number;
  IndividualRoomPage(this.number);

  @override
  State<IndividualRoomPage> createState() => _IndividualRoomPageState();
}

class _IndividualRoomPageState extends State<IndividualRoomPage> {
  List<int> counts = List.generate(items.length, (index) => 0);
  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.sizeOf(context).width/6;
    double imageHeight = MediaQuery.sizeOf(context).height/8;
    return Scaffold(
      appBar: AppBar(title: Text("Room ${widget.number}"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: List<Widget>.generate(items.length, (index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Image.asset(items[index].toLowerCase()+".png", width: imageWidth, height: imageHeight,),
              Text(items[index]),
              ConstrainedBox(
                constraints: BoxConstraints.loose(Size(70, double.infinity)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  ElevatedButton(onPressed: () {
                    setState(() {
                      counts[index] += 1;
                    });
                  },
                  child: const Icon(Icons.add),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(counts[index].toString())),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      counts[index] -= 1;
                    });
                  },
                  child: const Icon(Icons.remove),
                  )
                ],),
              ),
              ]
            );
          })
        ),
      )
    
    );
  }
}