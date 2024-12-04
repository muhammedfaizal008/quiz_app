// ignore_for_file: prefer_const_constructors

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/Dummydb.dart';
import 'package:quiz_app/view/result_screen/result_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class QuizScreen extends StatefulWidget {
  final int index;

  QuizScreen({required this.index, super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int count = 0;
  int rightAnswerCount = 0;
  int? selectedIndex;
  bool isProcessingNext = false;
  final int _duration = 10;
  final CountDownController _controller = CountDownController();

  void moveToNextQuestion() {
    final questions = Dummydb.content[widget.index]["key"];
    if (count < questions.length - 1) {
      setState(() {
        count++;
        selectedIndex = null;
      });
      _controller.restart(duration: _duration);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(rightAnswerCount: rightAnswerCount, index: widget.index),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = Dummydb.content[widget.index]["key"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: LinearPercentIndicator(
          barRadius: Radius.circular(20),
          lineHeight: 8.0,
          percent: count / questions.length,
          progressColor: Colors.black,
        ),
        actions: [
          Text(
            "${count + 1}/${questions.length}",
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          CircularCountDownTimer(
            duration: _duration,
            initialDuration: 0,
            controller: _controller,
            width: 40,
            height: 60,
            ringColor: Colors.grey[300]!,
            fillColor: Colors.black,
            strokeWidth: 10.0,
            strokeCap: StrokeCap.round,
            textStyle: TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.S,
            autoStart: true,
            onComplete: () {
              if (!isProcessingNext) {
                isProcessingNext = true;
                moveToNextQuestion();
                isProcessingNext = false;
              }
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  children: [
                    if (selectedIndex == questions[count]["answer"])
                      Center(
                        child: Lottie.asset(
                          "assets/animations/celebration_animations.json",
                        ),
                      ),
                    Center(
                      child: Text(
                        questions[count]["ques"],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: List.generate(
              4,
              (optionIndex) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    if (selectedIndex == null) {
                      setState(() {
                        selectedIndex = optionIndex;
                        if (optionIndex == questions[count]["answer"]) {
                          rightAnswerCount++;
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: getColor(optionIndex, questions),
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              questions[count]["options"][optionIndex],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Icon(
                          selectedIndex == optionIndex
                              ? Icons.circle
                              : Icons.circle_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (selectedIndex != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  if (!isProcessingNext) {
                    isProcessingNext = true;
                    moveToNextQuestion();
                    isProcessingNext = false;
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text("Next", style: TextStyle(color: Colors.white))),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color getColor(int optionIndex, List questions) {
    if (selectedIndex != null) {
      if (optionIndex == questions[count]["answer"]) {
        return Colors.green;
      }
      if (optionIndex == selectedIndex &&
          selectedIndex != questions[count]["answer"]) {
        return Colors.red;
      }
    }
    return Colors.blueGrey;
  }
}
