import 'package:flutter/material.dart';
import './login_utils.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Login With Google", style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white: Colors.black, fontSize: 20),),
          Center(child: ElevatedButton(child: Image.asset("assets/google.webp", width: 35,), onPressed: () => LoginController.login(context) )),
        ],
      ),
    );
  }
}