
import 'package:flutter/material.dart';
import 'package:helper_app/Screens/login_page.dart';

import 'Screens/register_page.dart';
import 'Widgets/animation.dart';



void main() async {
  runApp(MaterialApp(home : MyApp()));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("First Screen")),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Login'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(child: new Text("Register"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                ),
                RaisedButton(child: new Text("Login"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }

}
