
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_game/view/homescreen.dart';
import 'package:math_game/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a class named AuthServices that extends ChangeNotifier
class AuthServices extends ChangeNotifier {
  // Initialize text editing controllers for login and registration fields
  TextEditingController logEmails = TextEditingController();
  TextEditingController logPass = TextEditingController();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  // Initialize Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Initialize Firestore instance
  final firestore = FirebaseFirestore.instance;

  // Function for creating a new user account
  Future<void> newAccount(context) async {
    try {
      // Create authentication account with email and password
      final user = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );

      // Get data from Cloud Firestore
      DocumentSnapshot snapshot =
      await firestore.collection('users').doc(emailController.text).get();

      // Check if Firestore contains a user collection for the provided email
      if (snapshot.exists) {
        Fluttertoast.showToast(msg: "User email already exists");
      } else {
        // If the user is new, store their data in the collection
        firestore.collection('users').doc(user.user!.uid).set({
          "Name": userNameController.text,
          "Address": addressController.text,
          "Mobile": mobileController.text,
          "Email": emailController.text,
          "Password": passController.text,
        });
        Fluttertoast.showToast(
            msg: "Registration Successful", fontSize: 20);
        // Redirect to the login screen
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const login()));
      }
    } on FirebaseAuthException catch (e) {
      // Handle exceptions related to Firebase Authentication
      Fluttertoast.showToast(msg: e.toString(), textColor: Colors.red);
    }
  }

  // Function for user login
  Future<void> loginUser(context) async {
    try {
      // Sign in the user using email and password
      final user = await _auth.signInWithEmailAndPassword(
        email: logEmails.text,
        password: logPass.text,
      );

      if (user != null) {
        // If login is successful, navigate to the home screen
        print("Login Successful");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeScreen()));

        // Save the user's ID using shared preferences for future use
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userID", user.user!.uid);
        print("User ID saved: ${prefs.getString("userID")}");
      }
    } on FirebaseAuthException catch (e) {
      // Handle exceptions related to Firebase Authentication during login
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "No user found for that email.",
          gravity: ToastGravity.CENTER,
          textColor: Colors.redAccent,
          fontSize: 20.0,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Wrong password provided for that user",
          gravity: ToastGravity.CENTER,
          textColor: Colors.redAccent,
          fontSize: 20.0,
        );

      } else {
        Fluttertoast.showToast(
          msg: e.message ?? "Login failed",
          textColor: Colors.redAccent,
          fontSize: 20.0,
        );
      }
    }
  }

  // Function to log out the user
  Future<void> logoutUser() async {
    // Sign out the user
    await _auth.signOut();

    // Clear stored data in the shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    print("User logout Successful");
  }
}
