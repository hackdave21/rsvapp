import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 70, 125),
        leading: HeroIcon(
          HeroIcons.bars3BottomLeft,
          color: Colors.white,
          size: 34,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: HeroIcon(
              HeroIcons.bell,
              color: Colors.white,
              size: 34,
            ),
          ),
        ],
      ),
      body: Center(
      child: Text("Maison"),
    ),
    );
  }
}