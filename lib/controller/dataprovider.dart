
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:math_game/model/apimodel.dart';
import 'package:math_game/controller/fetchapiservice.dart';

class DataProvider extends ChangeNotifier {
  
  // Instances 
  late Timer _timer;
  String secondString = '00';
  int seconds = 0;
  
  TomatoModal? post;
  bool loading = false;

  bool _isButtonDisabled = true;

  bool showResult = false;

  int _count = 0;

  late int realScore = 0;

  String _name = "";

  String _result = "No Result";

  // Getter methods
  int get count => _count;

  bool get solResult => showResult;

 int get rScore  => realScore;

  String get resultCorrection => _result;

  bool get btnResult => _isButtonDisabled;

  String get names => _name;

  String get secondsResult => secondString;

  int get secondTimer => seconds;

  // Function to fetch json data from the api and stored in the model class
  getPostData() async {
   loading = true;
    post = (await TomatoApi().getDatas());
   // print(post!.solution);
   loading = false;
    notifyListeners();
  }

  // Function for score increment
  void increment() {
    _count++;
    _isButtonDisabled = false;
    notifyListeners();
  }

  // Return function for display score result
  int getData() {
    print("My Score is: $_count");
    return _count;
   // notifyListeners();
  }
  
  // Function for score data reset
  void resetData() {
    _count = 0;
    notifyListeners();
  }
  
  // Function for reset submit button  after disable by provide right answer
  void resetButton() {
    _isButtonDisabled = true;
    notifyListeners();
  }

  // Function for score reset after exit from the game
  void resetScore() {
    _count = 0;
    notifyListeners();
  }

  // Function for store string data correct
  void resCorrect() {
    _result = "Correct";
    print(_result);
    notifyListeners();
  }

  // Function for store string data incorrect
  void resIncorrect() {
    _result = "Incorrect";
    print(_result);
    notifyListeners();
  }

  // Function for store string data no result
  void resetRes() {
    _result = "No Result";
    print(_result);
    notifyListeners();
  }

  // Function for timer result reset after reached at end
  void timerResultReset() {
    showResult = false;
    notifyListeners();
  }

  // Timer function for start the time
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    startSecond();

    // Check condition and when result meet then timer stop
    if (seconds == 30) {
     _timer.cancel();
     showResult = true;
    }

    });
   // notifyListeners();
  }

  // Timer function for pause the time
  void pauseTimer() {
    _timer.cancel();
    notifyListeners();
  }

// Timer function for reset the time
void resetTimer() {
  _timer.cancel();
  seconds = 0;
  secondString = "0";
  notifyListeners();
}

  // Timer function to increase the time by 1 second
  void startSecond() {
    seconds ++;
    secondString = seconds.toString();
    if (secondString.length == 1){
      secondString = "0" + secondString;
    }
    notifyListeners();
  }

 // Function to get user detail from the cloud fire store and authentication
  Future<void>  getUserDetail() async {
   // Get the current user userid after logging on to the system 
  final user = FirebaseAuth.instance.currentUser;
  final uid1 = user!.uid;

  // Get userid from the firestore
  final getUser = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot snapshot = await getUser.doc(uid1).get();

  // Store the current user data with the help of userid and stored data in  map format in variable
  var data1 = snapshot.data() as Map;
  
    // Store in string variable
  _name = data1['Name'];
  notifyListeners();
  
  }

  // Function to store user game score
  Future<void> putScore() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid1 = user!.uid;
    final firestore = FirebaseFirestore.instance;

    DocumentSnapshot snapshot = await firestore.collection('scores').doc(uid1).get();

   if (snapshot == null || !snapshot.exists) {
      firestore.collection('scores').doc(uid1).set({
       "Name" : _name,
       "Score" : _count
  } 
  );
   }
    else {
    var data1 = snapshot.data() as Map;
    int Scores = data1['Score'];

    realScore = _count + Scores;
    print("update score: $realScore");
    firestore.collection('scores').doc(uid1).set(
    {
      "Name" : _name,
      "Score" : realScore
      }
  );

    }

    
  notifyListeners();
  }

  // Function to display user game score
  Future<void> showScore() async {
   final user = FirebaseAuth.instance.currentUser!.uid;
   final firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await firestore.collection('scores').doc(user).get();
     var data1 = snapshot.data() as Map;
    int Scores = data1['Score'];

    realScore = _count + Scores;
    notifyListeners();

  }

  // Google Input Score
  Future<void> storeScore() async {
   final user = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;
    String? names = FirebaseAuth.instance.currentUser!.displayName;
    DocumentSnapshot snapshot = await firestore.collection('scores').doc(user).get();

   if (snapshot == null || !snapshot.exists) {
      firestore.collection('scores').doc(user).set({
       "Name" : names,
       "Score" : _count
  } 
  );
   }
    else {
      DocumentSnapshot snapshot = await firestore.collection('scores').doc(user).get();
    var data1 = snapshot.data() as Map;
    int Scores = data1['Score'];

    realScore = _count + Scores;
    print("update score: $realScore");
    firestore.collection('scores').doc(user).set(
    {
      "Name" : names,
      "Score" : realScore
      }
  );

    }

  notifyListeners();
  }
 }


