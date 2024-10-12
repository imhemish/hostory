import 'package:flutter/material.dart';
import 'package:hostory/db.dart';

class AddRoomPage extends StatefulWidget {

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final _formKey = GlobalKey<FormState>();  // GlobalKey for the form
  final _roomNumberController = TextEditingController();
  final _resident1Controller = TextEditingController();
  final _resident2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Room"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,  // Assign the GlobalKey to the form
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _buildRoomNumberField(),
                    SizedBox(height: 20),
                    _buildResidentField("Resident 1", _resident1Controller),
                    SizedBox(height: 20),
                    _buildResidentField("Resident 2", _resident2Controller),
                    SizedBox(height: 30),
                    _buildAddButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoomNumberField() {
    return TextFormField(
      controller: _roomNumberController,
      decoration: InputDecoration(
        labelText: "Room Number",
        hintText: "Enter room number",
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.lightBlue[50],
      ),
      keyboardType: TextInputType.number,
      validator: (value) => int.tryParse(value!) == null
          ? "Please enter a numeric value"
          : null,
    );
  }

  Widget _buildResidentField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: "Enter $label name",
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.lightBlue[50],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {  // Validate the form using the GlobalKey
          (BuildContext ctx) async {
            var result = await Database.addRoom(
              int.parse(_roomNumberController.text),
              _resident1Controller.text,
              _resident2Controller.text,
            );
            if (result.$1) {
              if (context.mounted) {
                Navigator.pop(ctx);
              }
            } else {
              if (context.mounted) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${result.$2}")));}
            }
          }(context);
        }
      },
      child: Text("Add"),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
