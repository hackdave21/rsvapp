import 'package:flutter/material.dart';
import 'package:rvsapp/mainhome_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bienvenue", style: TextStyle(
            color: const Color.fromARGB(255, 2, 70, 125),
            fontSize: 17
          ),),
          // SizedBox(height: 150,),
          Container(
            margin: EdgeInsets.only(top: 390),
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 70, 125), 
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.lightBlue)
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainhomeScreen()),
    );
              },
              child: Text("Passer", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
            ),
          )
        ],
       ),
     ),
    );
  }
}