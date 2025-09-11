import 'package:flutter/material.dart';
import 'package:rvsapp/features/presentation/pages/mainhome_screen.dart';

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
           SizedBox(height: 150,),
           Padding(
             padding: const EdgeInsets.all(18),
             child: SizedBox(
              
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                      Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => MainhomeScreen()),
                 );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 70, 125),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Passer',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
           ),
        ],
       ),
     ),
    );
  }
}