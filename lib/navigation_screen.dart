import 'package:flutter/material.dart';
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SecondRoute(routeName: 'Second Route Py ho Ap',)),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  String routeName;
   SecondRoute({required this.routeName,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child:  Text('Go back! $routeName'),
        ),
      ),
    );
  }
}