import 'package:flutter/material.dart';
import 'package:hostory/widgets/room.dart';

class Rooms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      mainAxisSpacing: 10, 
      crossAxisSpacing: 10,),
      itemBuilder: (context, index) {
        return Room(index+1);
      },
      itemCount: 10,
      );
  }
}