
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:math_game/controller/userdetail.dart';

class MyScore extends StatefulWidget {
  const MyScore({super.key});

  @override
  State<MyScore> createState() => _MyScoreState();
}

// Score view function
class _MyScoreState extends State<MyScore> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postModel = Provider.of<UserDetail>(context, listen: false);
    postModel.levelGrow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE63A00),
        title: const Text("My Score"),
        centerTitle: true,
      ),

      body: Consumer<UserDetail>(
        builder: (context, value, child) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x0e7fc1f4),
                  Color(0xaa8bb4e5),
                  Color(0xd3a0c8ef),
                  Color(0xffaed1ff),
                ])
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFE63A00),
                    radius: 100,
                    child:  Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 68.0),
                        child: Column(
                          children: [
                            const Text("Total Score", style: TextStyle(color: Colors.white,fontSize: 23, fontWeight: FontWeight.bold)),
                            Text("${value.getScore}",
                            style: const TextStyle(color: Colors.white,fontSize: 23, fontWeight: FontWeight.bold),
                        ),

                        // Level score text
                        Text("Level: ${value.getLevel}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,

                        ),)
                          ],

                        ),
                      ),
                    )

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE63A00),
                  minimumSize: const Size(200 , 60),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
                ),
               onPressed: () async {
                value.deleteScore();
                value.getTotalScore();
               // value.levelGrow();
               // final postModel = Provider.of<UserDetail>(context, listen: false);
               }, 
                icon: const FaIcon(FontAwesomeIcons.arrowDownLong, color: Colors.blue,),
                label: const Text('Reset',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                    ),),
                ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}