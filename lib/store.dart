import 'package:flutter/material.dart';
import 'package:hostory/db.dart';
import 'items.dart';

class Store extends StatefulWidget {
  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  List<int> counts = List.generate(items.length, (index) => 0);

  RoomDetails? roomDetails;

  bool loading = true;

  Future<void> _loadStoreDetails() async {
    var result = await Database.getStoreDetails();
    if (result.$1 != null) {
      setState(() {
        loading = false;
        roomDetails = result.$1;
      });
    } else {
      if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Loading Failed: ${result.$2}")));
      }
    }
  }

  @override
  void initState() {
    loading = true;
    _loadStoreDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.sizeOf(context).width / 6;
    double imageHeight = MediaQuery.sizeOf(context).height / 8;

    if (loading == false) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Store")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List<Widget>.generate(items.length, (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/" + items[index].toLowerCase() + ".png", 
                        width: imageWidth, 
                        height: imageHeight,
                      ),
                      Text(items[index]),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              var itemName = items[index];
                              var currentItemCount = roomDetails!.counts[itemName]!;

                              () async {
                                var result = await Database.increaseStoreItem(items[index], 1);
                                if (result.$1) {
                                  setState(() {
                                    roomDetails!.counts[itemName] = currentItemCount+1;
                                  });
                                } else {
                                  if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update Failed")));
                                  }
                                }
                              } ();
                            
                            },
                            child: const Icon(Icons.add),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(roomDetails!.counts[items[index]].toString()),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              var itemName = items[index];
                              var currentItemCount = roomDetails!.counts[itemName]!;

                              if (currentItemCount == 0) {
                                return;
                              }

                              () async {
                                var result = await Database.decreaseStoreItem(items[index], 1);
                                if (result.$1) {
                                  setState(() {
                                    roomDetails!.counts[itemName] = currentItemCount-1;
                                  });
                                } else {
                                  if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update Failed")));
                                  }
                                }
                              } ();
                            },
                            child: const Icon(Icons.remove),
                          )
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
    } else {
      return Center(child: CircularProgressIndicator.adaptive(),);
    }
  }
}