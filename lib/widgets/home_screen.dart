import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
backgroundColor: Colors.yellow,
appBar: AppBar(
  title: Text("Congratulations,you have successfully log in"),
),
    );
  }
}
