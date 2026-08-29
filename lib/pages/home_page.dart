import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.widthOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Open Exchange'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(child: Center()),
    );
  }
}
