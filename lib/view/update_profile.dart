import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_game/controller/userdetail.dart';
import 'package:math_game/view/viewprofile.dart';

class UpdateMyProfile extends StatefulWidget {
  const UpdateMyProfile({super.key});

  @override
  State<UpdateMyProfile> createState() => _UpdateMyProfileState();
}

class _UpdateMyProfileState extends State<UpdateMyProfile> {

  final _formKey = GlobalKey<FormState>();

  // Variable declaration for password visible or invisible
  late bool _passwordVisible;
  UserDetail ud = UserDetail();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final postModel = Provider.of<UserDetail>(context, listen: false);
    postModel.getUserDetail();
    ud.userNameController.text = postModel.getName;
    ud.addressController.text = postModel.getAddress;
    ud.mobileController.text = postModel.getPhone;
    ud.emailController.text = postModel.getEmail;
    ud.passController.text = postModel.getPassword;

     _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    final postModel = Provider.of<UserDetail>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE63A00),
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyProfile()))
        ),
        centerTitle: true,
        title: const Text("Update Profile"),
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
            padding: const EdgeInsets.only(top: 30, left: 20.0, right: 20, bottom: 20),
            child: Column(
              children: [
        
                // Username 
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    controller: ud.userNameController,

                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      label: const Text("Name"),
                      hintText: "Enter User name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(),
                      )
                    ),


                  ),
                ),
        
        
                // Address 
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: ud.addressController,
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        label: const Text("Address"),
                        hintText: "Enter Your Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide()
                        )
                      ),
                      
                      
                    ),
                  ),
                ),
        
                // Mobile Number
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    controller: ud.mobileController,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      label: const Text("Mobile"),
                      hintText: "Enter Mobile Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide()
                      )
                    ),

                  ),
                ),
        
                // Email
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    controller: ud.emailController,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                    readOnly: true,
                    decoration: InputDecoration(
                      label: const Text("Email"),
                      hintText: "Enter Your Email Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide()
                      )
                    ),

                  ),
                ),

                // Password Form 
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                     obscureText: !_passwordVisible,
                    controller: ud.passController,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          // Update the state
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      ),
                      label: const Text("Password"),
                      hintText: "Enter Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide()
                      )
                    ),

                  ),
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

            ),
                    onPressed: () {
                      ud.updateUser();
                      dispose();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfile()));
                    },
                    child: const Text('Update',
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
    );
  }
}