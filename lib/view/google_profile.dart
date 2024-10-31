
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_game/controller/google_sigin_service.dart';
import 'package:math_game/controller/dataprovider.dart';


class GoogleProfile extends StatefulWidget {
  const GoogleProfile({super.key});

  @override
  State<GoogleProfile> createState() => _GoogleProfileState();
}

// Google profile screen
class _GoogleProfileState extends State<GoogleProfile> {

  GoogleService gp = GoogleService();

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE63A00),
        title:  const Text("Profile"),
        centerTitle: true,
      ),

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80, right: 80, left: 80, bottom: 20),
                child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!,),  
                          backgroundColor: const Color(0xFFE63A00),
                        ),
              ),

              // Name from google
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 20, right: 20),
                child: Text("Name: ${FirebaseAuth.instance.currentUser!.displayName}",
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Email: ${FirebaseAuth.instance.currentUser!.email}",
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 20, right: 20),
                child: Text("Score: ${postModel.rScore}",
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}