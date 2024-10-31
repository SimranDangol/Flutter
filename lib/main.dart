import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_game/controller/auths.dart';
import 'package:math_game/controller/userdetail.dart';
import 'package:math_game/controller/dataprovider.dart';
import 'package:math_game/view/login.dart';

void main() async {

  // Initialize the firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
        ChangeNotifierProvider(create: (_) => UserDetail()),
        ChangeNotifierProvider(create: (_) => AuthServices()),
      ],
          child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  AuthServices au = AuthServices();

  // This widget is the root the application.
  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}

