import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_game/controller/auths.dart';
import 'package:math_game/view/login.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

// Create registration screen
class _RegistrationFormState extends State<RegistrationForm> {

  final _formKey = GlobalKey<FormState>();

  AuthServices au = AuthServices();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE63A00),
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const login()))
        ),
        centerTitle: true,
        title: const Text("Register Your Account"),
      ),
      
      body: Container(
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
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
        
                  // Username 
                  TextFormField(
                    controller: au.userNameController,
                    decoration: InputDecoration(
                      hintText: "Enter User name",
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
        
                  const SizedBox(height: 15.0,),
        
                  // Address 
                  TextFormField(
                    controller: au.addressController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Address",
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

                  const SizedBox(height: 15.0,),
        
                  // Mobile Number
                  TextFormField(
                    controller: au.mobileController,
                    decoration: InputDecoration(
                      hintText: "Enter Mobile Number",
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
        
                  const SizedBox(height: 15.0,),
        
                  // Email
                  TextFormField(
                    controller: au.emailController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email Address",
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
        
                  const SizedBox(height: 15.0,),

                  // Password Form 
                  TextFormField(
                    controller: au.passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
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
        
                  const SizedBox(height: 15.0,),

                  // Confirm Password
                  TextFormField(
                    controller: au.confirmPassController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Confirm Password",
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
        
                  const SizedBox(height: 15.0,),
                  

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
               
              ),  // Taking email and confirming password from user
                      onPressed: () {
                        if (_formKey.currentState!.validate()){
                          bool isValid = EmailValidator.validate(au.emailController.text);

                          if (isValid) {
                            if (au.passController.text == au.confirmPassController.text) {
                            au.newAccount(context);
                            }
                            else {
                              Fluttertoast.showToast(msg: "Password did not match",
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.redAccent,
                              fontSize: 20.0);
                            }
                          }
                          else {
                            Fluttertoast.showToast(
                              msg: "Invalid Email",
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.redAccent,
                              fontSize: 20.0
                              );
                          }
                        }
                        
                      }, 
                      child: const Text('Register', 
                      style: TextStyle(
                        fontSize: 23, 
                        fontWeight: FontWeight.bold
                        ),
                        ), 
                      ),
                  )
                ],
              )
              ),
          ),
        ),
      ),
    );
  }
}