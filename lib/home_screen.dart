import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        actions: [
          Icon(Icons.menu),
        ],
        title: Text("Batch 24"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Container(
                  height: 300,
                  width: 300,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Students"),
                  )),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
              Text("Students"),
            ],
          ),
        ),
      ),
    );
  }
}
