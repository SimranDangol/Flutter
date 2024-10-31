import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:math_game/controller/auths.dart';
import 'package:math_game/controller/userdetail.dart';
import 'package:math_game/controller/dataprovider.dart';
import 'package:math_game/view/homescreen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

 final TextEditingController user1 = TextEditingController();

  // Variable Declaration
 final String _resultCheck = "No Result";
 String res = "";

 int score = 0;
 int tries = 0;
 late int _selectedNums = 0;

// List of integer from 0 to 9 and stored in variable
 List<int> nums = [0,1,2,3,4,5,6,7,8,9];

// Object Creation
AuthServices au = AuthServices();
UserDetail ud = UserDetail();

@override
  void initState() {

    // Call all the function at the time of page running
    super.initState();
    final postModel = Provider.of<DataProvider>(context, listen: false);
   // postModel.getPostData(); 
    postModel.getUserDetail();
    postModel.startTimer();
    
    final scoreModel = Provider.of<UserDetail>(context, listen: false);
    scoreModel.getUserDetail();

  }

  @override
  Widget build(BuildContext context) {
    final scoreModel = Provider.of<UserDetail>(context, listen: false);
     return Consumer<DataProvider>(
       builder: (context, providerValue, child) {
         return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFE63A00),
            title: const Text("Game Screen"),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
             body: Padding(
               padding: const EdgeInsets.only(top:30),
               child: SizedBox(
                // color: Colors.blueAccent,
                 height: 900,
                 width: 400,
               
                 child: Column(
                   children: [
                     Image(image: NetworkImage(providerValue.post!.question.toString())),
                     
                     const SizedBox(height: 35),
                     Padding(
                       padding: const EdgeInsets.only(top: 5, bottom: 5),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [

                         // Drop Down menu
                         Padding(
                           padding: const EdgeInsets.only(left: 10),
                           child: SizedBox(
                             height: 60,
                             width: 90,
                             child: DropdownButtonFormField<int>(
                                   icon: const Icon(Icons.arrow_downward),
                                   iconSize: 24,
                                   elevation: 16,
                                   isExpanded: true,
                                   style: const TextStyle(color: Color(0xFFE63A00), fontSize: 20),

                             decoration: InputDecoration(
                                         enabledBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(12),
                                         borderSide: const BorderSide(width: 3, color: Color(0xFFE63A00))
                            )
                          ),
                             items: nums.map((int dropDownValue) {
                          return DropdownMenuItem<int>(
                           value: dropDownValue,

                           child: Text(dropDownValue.toString())
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _selectedNums = newVal!;
              if (kDebugMode) {
                print(_selectedNums);
              }
            }

            );
          },
          value: _selectedNums,

          ),
                           ),
                         ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: ElevatedButton(

                             onPressed: (){
                             var res1 = providerValue.post!.solution;

                             bool resButton = providerValue.btnResult;

                       // To check condition for the correct answer
                              if (resButton) {
                              // Condition for timer
                              if (providerValue.secondTimer < 30) {

                              // Condition for correct answers
                              if ( res1 == _selectedNums){
                       providerValue.increment();
                       providerValue.getData();
                       providerValue.resCorrect();
                       providerValue.pauseTimer();
                              // providerValue.getPostData();
                              // providerValue.resetRes();
                       // providerValue.resetScore();
                              // providerValue.resetButton();
                             }
                             else{
                       providerValue.resIncorrect();
                       tries += 1;
                       if (kDebugMode) {
                         print("Try: $tries");
                       }
                             }
                          }

                              else if (providerValue.secondTimer == 30){
                        Fluttertoast.showToast(msg: "Timed Out", textColor: const Color(0xFFE63A00));
                              }
                       }
                         },
                       style: ElevatedButton.styleFrom(
                        backgroundColor: providerValue.btnResult ? const Color(0xFFE63A00) : Colors.blueAccent
                       ),
                       child:  const Text("Submit",
                       ),),
                          ),

                     //  const SizedBox(height: 15,),

                       Padding(
                         padding: const EdgeInsets.only(left: 13.0),
                         child: ElevatedButton(
                         onPressed: () {
                           providerValue.getPostData();
                           providerValue.resetRes();
                           providerValue.resetButton();
                          providerValue.resetTimer();
                          providerValue.timerResultReset();
                          providerValue.startTimer();
                          _selectedNums = 0;
                         },
                             style: ElevatedButton.styleFrom(
                                 backgroundColor: const Color(0xFFE63A00), // Background color for the "New Game" button
                             ),
                         child: const Text("New Game")),
                       ),

                       Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton(onPressed: (){
               providerValue.putScore();
               providerValue.resetTimer();
               providerValue.timerResultReset();
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
             },
                           style: ElevatedButton.styleFrom(
                             backgroundColor: const Color(0xFFE63A00), // Background color for the "New Game" button
                           ),
                           child: const Text("Quit")),
                     ),
                         ],
                       ),
                     ),
                    const SizedBox(
                     height: 35,
                    ), 
                    
                     Row(
                       children: [

                         Padding(
                 padding: const EdgeInsets.only(left:35.0),
                 child: Text(providerValue.resultCorrection,
                 style: const TextStyle(fontSize: 20, color: Color(0xFFE63A00)),
                 ),
               ),

                         Padding(
                 padding: const EdgeInsets.only(left:50.0),
                 child: Text(providerValue.solResult ?
                  "Hint: ${providerValue.post!.solution}" : ""
                  , style: const TextStyle(fontSize: 20),),
               ),

               Padding(
                 padding: const EdgeInsets.only(left:50.0),
                 child: Text("Score: ${providerValue.count}", style: const TextStyle(fontSize: 20),),
               ),
                       ],
                     ),

                      const SizedBox(height: 30,),
                     // Timer Screen
                     Text(providerValue.secondString,
                     style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
                     )

                   ],
                 ),    
               ),
             ),
           );
       },  
       
     );    
  
  }
}