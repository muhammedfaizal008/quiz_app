// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quiz_app/Dummydb.dart';
import 'package:quiz_app/view/Quiz_screen/quiz_screen.dart';
import 'package:quiz_app/view/home_screen/home_screen.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatefulWidget {
  int rightAnswerCount;
  int index;
   ResultScreen({
    required this.index,
    super.key,required this.rightAnswerCount});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int starcount=0;
  String performanceText="";
  @override
  void initState() {
    calculatePercentage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(3, (index) => 
            Icon(Icons.star,color: starcount>index?Colors.amber:Colors.grey,size: index==1?70:40,),
            )
          ),
          SizedBox(height: 50,),
          Center(
            child: Text(performanceText,style: TextStyle(
              color: Colors.amber,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(height: 30,),
          Text("Your Score",style: TextStyle(
            color: Colors.black
          ),),
          Text("${widget.rightAnswerCount} / ${Dummydb.flutter.length}",style: TextStyle(
            color: Colors.amber,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizScreen(index: widget.index,),));
                    },
                    child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.rotate_left),
                              SizedBox(width: 10,),
                              Text("Retry",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),),
                            ],
                          ),
                        ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
              onTap: (){
                Share.share('check out my website https://example.com');
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
                ),
                child: Icon(Icons.share,color: Colors.white,),
              ),
            )
              ],
            ),
          ),
          TextButton(onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,);
          }, child: Text("Back to Home",style: TextStyle(
            color: Colors.black,
          ),))
        ],
      ),
    );
  }

   void calculatePercentage() {

  num percentage = (widget.rightAnswerCount / Dummydb.flutter.length) * 100;

  if (percentage >= 90) {
    starcount = 3;
    performanceText = "Congratulations!";
  } else if (percentage >= 50) {
    starcount = 2;
    performanceText = "Good Job!";
  } else if (percentage >= 10) {
    starcount = 1;
    performanceText = "Keep Trying!";
  } else {
    starcount = 0;
    performanceText = "Better Luck Next Time!";
  }

  setState(() {});
}

}