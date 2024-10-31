
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserDetail extends ChangeNotifier{

  // Instances for firestore and authentication
  final user = FirebaseAuth.instance.currentUser;
  final getUser = FirebaseFirestore.instance;
  
  // Text editing controller instances
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  // Declare variables
  String Name = "";
  String Address = "";
  String Email = "";
  String Phone = "";
  String Password = "";

  int Scores = 0;
  int level = 0;

  // Getter methods
  int get getScore => Scores;
  int get getLevel => level;
  String get getName => Name;
  String get getAddress => Address;
  String get getEmail => Email;
  String get getPhone => Phone;
  String get getPassword => Password;

  // Function to get user data from cloud fire store
 Future<void>  getUserDetail() async {
  final uid1 = user!.uid;
  DocumentSnapshot snapshot = await getUser.collection('users').doc(uid1).get();

  if (snapshot == null || !snapshot.exists) {
      Fluttertoast.showToast(msg: "User does not Exist");
      
   }
   else {
    var data1 = snapshot.data() as Map;

  Name = data1['Name'];
  Address = data1['Address'];
  Email = data1['Email'];
  Password = data1['Password'];
  Phone = data1['Mobile'];
   }
  notifyListeners();
 }
 
 // Function to user game played score data from the cloud database
 Future<void>  getTotalScore() async {
  
  final uid1 = user!.uid;
  DocumentSnapshot snapshot = await getUser.collection('scores').doc(uid1).get();
  
  
  if (snapshot == null || !snapshot.exists) {
      Fluttertoast.showToast(msg: "Score does not Exist");
      Scores = 0;
      level = 0;
   }
   else {
    var data1 = snapshot.data() as Map;
    Scores = data1['Score'];
   }
  
  notifyListeners();
 }

 // Function for updating user data
 Future<void> updateUser() async {
  
 final firestore = FirebaseFirestore.instance;
  final uid1 = user!.uid;
 
 if (uid1 != null) {
  firestore.collection('users').doc(uid1).set({
    "Name" : userNameController.text,
    "Address" : addressController.text,
    "Mobile" : mobileController.text,
    "Email" : emailController.text,
    "Password" : passController.text
  }
  );
  await user!.updatePassword(passController.text);
  Fluttertoast.showToast(msg: "Updated Successfully");
 }
 else {
  Fluttertoast.showToast(msg: "User Not Found");
 }

  notifyListeners();

 }

 // Function for deletion of user score
 Future<void> deleteScore() async {
  final uid1 = user!.uid;
  final firestore = FirebaseFirestore.instance;
  DocumentSnapshot snapshot = await firestore.collection('scores').doc(uid1).get();

  if (snapshot == null || !snapshot.exists) {
      Fluttertoast.showToast(msg: "User does not Exist");
   } 
   else {
    firestore.collection('scores').doc(uid1).delete(
  //       {
  //      "Name" : names,
  //      "Score" : _count
  // } 
  ).then((value) => Fluttertoast.showToast(msg: "Deletion Successful"))
  .catchError((error) => Fluttertoast.showToast(msg: "Failed to delete score $error"));
   }

   notifyListeners();
 }

 // Function to show user game level after getting score
  void levelGrow() {
    int scores = getScore;
    print(scores);
    if (scores == 0 || scores <= 15) {
      level = 1;
    }
    else if (scores > 15 || scores <= 30) {
      level = 2;
    }
    else if (scores > 30 || scores <= 45) {
      level = 3;
    }
    else {
      level = 4;
    }

   // notifyListeners();
  }
 
}