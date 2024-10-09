import 'package:flutter/material.dart';
import './login_utils.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Login With Google"),
          Center(child: ElevatedButton(child: Image.asset("assets/google.png", width: 35,), onPressed: () => LoginController.login(context) )),
        ],
      ),
    );
  }
}