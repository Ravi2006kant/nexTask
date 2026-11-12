import 'package:flutter/material.dart';
import 'package:nextask/home.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({super.key});

  @override
  State<Introscreen> createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  Future<void> next() async {
    await Future.delayed(const Duration(milliseconds: 2000));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  void initState() {
    super.initState();
    next();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,

        children: [
          Center(child: Image.asset('assets/logo.png', width: 100, height: 100)),
          Text(
            "NexTask",
            style: TextStyle(
              color: Colors.black,
              fontWeight: .bold,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
