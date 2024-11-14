// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quiz_app/Dummydb.dart';
import 'package:quiz_app/view/result_screen/result_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int count=0;
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Text("${count+1}/10",style: TextStyle(
            color: Colors.white
          ),),
          SizedBox(width: 10,)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(Dummydb.Question[count]["ques"],style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              ),
            ),
          ),
          Column(
            children: List.generate(4, (optionIndex) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                if(selectedIndex==null){
                  setState(() {
                  selectedIndex=optionIndex;
                });
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: getColor(optionIndex),
                  border: Border.all(width: 1,color: Colors.white,),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          Dummydb.Question[count]["options"][optionIndex],style: TextStyle(
                            color: Colors.white),
                            ),
                      ),
                    ),
                    Icon(selectedIndex==optionIndex?Icons.circle:Icons.circle_outlined,color: Colors.white,)
                  ],
                ),
              ),
            ),
          ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                setState(() {
                  if(count<Dummydb.Question.length-1){
                    count++;
                    selectedIndex=null;
                  }
                  else{
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultScreen(),));
                  }
                  
                });
              },
              child: Container(
                width:double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Next")),
              ),
            ),
          )
          
        ],
      ),
    );
  }
   Color getColor(int optionIndex) {
    if (selectedIndex != null) {
      if (optionIndex == Dummydb.Question[count]["answer"]) {
        return Colors.green;
      }
      if (optionIndex == selectedIndex &&selectedIndex != Dummydb.Question[count]["answer"]) {
        return Colors.red;
      }
    }
    return Colors.blueGrey;
  }
}

