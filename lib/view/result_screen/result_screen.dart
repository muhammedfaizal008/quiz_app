// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quiz_app/view/first_screen/first_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(3, (index) => 
            Icon(Icons.star,color: Colors.grey,size: index==1?70:40,),
            )
          ),
          SizedBox(height: 50,),
          Center(
            child: Text("Congratulations",style: TextStyle(
              color: Colors.amber,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(height: 30,),
          Text("Your Score",style: TextStyle(
            color: Colors.white
          ),),
          Text("6 / 10",style: TextStyle(
            color: Colors.amber,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FirstScreen(),));
              },
              child: Container(
                    width:double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.rotate_left),
                        SizedBox(width: 10,),
                        Text("Retry"),
                      ],
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}