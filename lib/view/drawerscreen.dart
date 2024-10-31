import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_game/controller/auths.dart';
import 'package:math_game/controller/dataprovider.dart';
import 'package:math_game/controller/userdetail.dart';
import 'package:math_game/view/login.dart';
import 'package:math_game/view/scoreview.dart';
import 'package:math_game/view/viewprofile.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  // Create an object of AuthServices class to get variables and methods
  AuthServices au = AuthServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Call the provider class and its functions
    final postModel = Provider.of<UserDetail>(context, listen: false);
    postModel.getTotalScore();
  }

  @override
  Widget build(BuildContext context) {
   final scoreModel = Provider.of<DataProvider>(context, listen: false);
   final postModel = Provider.of<UserDetail>(context, listen: false);
   
    return Scaffold(
      body: Consumer<UserDetail>(builder: (context, value, child) {
        return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader( // <-- SEE HERE
          decoration: const BoxDecoration(color: Color(0xFFE63A00)),

          accountName: Text(
            value.getName,
            style: const TextStyle(
              fontWeight: FontWeight.bold, 
            ),
          ),
          accountEmail: Text(
            value.getEmail,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          currentAccountPicture: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 52,
             // backgroundImage: ,
             child: Text((value.getName.isNotEmpty) ? value.getName[0].toUpperCase() : "",
             style: const TextStyle(
              fontSize: 18
             ),),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.people,
          ),
          title: const Text('Profile', style: TextStyle(fontSize: 20, color: Color(0xFFE63A00)),),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyProfile()));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.score,
          ),
          title: const Text('Score', style: TextStyle(fontSize: 20, color: Color(0xFFE63A00)),),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyScore()));
          },
        ),
        
        ListTile(
          leading: const Icon(
            Icons.logout,
          ),
          title: const Text('logout', style: TextStyle(fontSize: 20, color: Color(0xFFE63A00)),),
          onTap: () {
            au.logoutUser();
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const login()));
          
          },
        ),
      ],
    ),
  );
      }) ,
    
    );
  }
}