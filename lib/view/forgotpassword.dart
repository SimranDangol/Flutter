import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_game/view/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emails = TextEditingController();

  // Function for recovering password if user forget password by sending an email verification link
  forgotPassword() async {
    try {
      await FirebaseAuth.instance
      .sendPasswordResetEmail(email: emails.text);
      Fluttertoast.showToast(msg: "Reset password link successfully sent to this email");

    }
    on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        gravity: ToastGravity.CENTER
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE63A00),
        centerTitle: true,
        title: const Text("Verify Email"),
      ),

      body:  Container(
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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: emails,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                                decoration: InputDecoration(
                                  hintText: "Enter Email Address",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide()
                                  )
                                ),
                                validator: (value) {
                                  if(value == null || value.isEmpty){
                                    return "Required this field";
                                  }
                                  return null;
                                },
                                
                              ),
                  ),

                            const SizedBox(height: 35.0,),
                  

                  // Elevated Button
                  SizedBox(
                  height: 60,
                    width: 400,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE63A00),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
               
              ),
                      onPressed: () {

                        // Check whether the text field left blank or not
                        if (_formKey.currentState!.validate()){

                          // check the email validation and store boolean result
                          bool isValid = EmailValidator.validate(emails.text);

                          // Check whether the email valid or not
                          // if valid then route to different page
                          if (isValid) {
                            forgotPassword();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const login()));
                          }
                          else {
                            Fluttertoast.showToast(msg: "Invalid email address entered");
                          }
                        }
                      }, 
                      child: const Text('Verify', 
                      style: TextStyle(
                        fontSize: 23, 
                        fontWeight: FontWeight.bold
                        ),
                        ), 
                      ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      
                
      
    );
  }
}