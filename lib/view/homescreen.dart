
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_game/controller/dataprovider.dart';
import 'package:math_game/view/drawerscreen.dart';
import 'package:math_game/view/gamescreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// View screen for home
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postModel = Provider.of<DataProvider>(context, listen: false);
    postModel.getPostData();
    postModel.getUserDetail();
  // postModel.startTimer();
    
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE63A00),
        title: const Text("Main Menu"),
        centerTitle: true,
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () {
           // postModel.count;
           postModel.resetScore();
           postModel.resetRes();
           postModel.resetButton();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GameScreen()));
          },
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(170, 170),
              shape: const CircleBorder(),
              primary: const Color(0xFFE63A00),
          ),
          child: const Text('START',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
),
      ),
      
      drawer: const DrawerScreen(),
    );
  }
}