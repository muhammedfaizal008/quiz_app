// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quiz_app/Dummydb.dart';
import 'package:quiz_app/utils/images/images.dart';
import 'package:quiz_app/view/Quiz_screen/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              firstSection(),
              SizedBox(height: 20),
              gridViewSection(Dummydb.content),
            ],
          ),
        ),
      ),
    );
  }

  Column gridViewSection(List<Map<String, dynamic>> content) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's Play",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                MasonryGridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: Dummydb.content.length,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(index: index,),));
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: index == 0 ? 168 : 198, 
                            color: Colors.white,
                            child: Align(
                              alignment: Alignment.bottomCenter, 
                              child: Container(
                                height: index == 0 ? 155 : 185, 
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(Dummydb.content[index]["name"],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),),
                                      SizedBox(height: 5,),
                                      Text("${Dummydb.content[index]["key"].length} Questions",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),),
                                      SizedBox(height: 5,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            child: Image.asset(
                              StackImages.images[index]),
                          )
                        ],
                      ),
                    );
                  },
                ),

              ],
            );
  }

  Column firstSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, User",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Let's make this day productive",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )
              ],
            ),
            CircleAvatar(
              radius: 20,
            )
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Image.network(
                    height: 50,
                    "https://media.istockphoto.com/id/1176397624/vector/vector-flat-golden-trophy.jpg?s=612x612&w=0&k=20&c=kjnN3SB3l1cAMMt5xUvnyJDfPzQKzZ_pZHt3jaFnmF0=",
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ranking",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "1000",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              VerticalDivider(
                color: Colors.grey,
                thickness: 1,
                width: 20,
                indent: 10,
                endIndent: 10,
              ),
              Row(
                children: [
                  Image.network(
                    height: 40,
                    "https://thumb.ac-illust.com/4f/4ff6ce5af92b49bff4fa0db23515f6b3_t.jpeg",
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Points",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "1000",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
