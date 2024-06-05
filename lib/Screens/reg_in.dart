import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class regScreen extends StatefulWidget {

  @override
  _regScreenState createState() => _regScreenState();
}

/* var email;
  var password;

register()async{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseUser user = await firebaseAuth.createUserWithEmailAndPassword(email: null, password: null)

}*/
//const regScreen({super.key});
class _regScreenState extends State<regScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Optionally update user display name
        await userCredential.user!.updateDisplayName(_fullNameController.text);
        print("User signed up: ${userCredential.user}");
      } else {
        print("Passwords do not match");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children:[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF000080),
                    Color(0xFF87CEEB),
                    ]
                  )
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0,left: 22),
                child: Text('Create Your\nAccount',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),topRight: Radius.circular(40)
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30.0,),
                       TextField(
                       controller: _fullNameController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check,color: Colors.grey,),
                            label: Text('Full Name',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xFF000080),
                            ),
                            )
                        ),

                      ),

                       TextField(
                         controller: _emailController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.check,color: Colors.grey,),
                            label: Text('Phone or Gmail',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xFF000080),
                            ),)
                        ),
                      ),
                       TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.visibility_off,color: Colors.grey,),
                            label: Text('Password',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xFF000080),
                            ),)
                        ),
                      ),
                       TextField(
                         controller: _confirmPasswordController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.visibility_off,color: Colors.grey,),
                            label: Text('Confirm Password',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:Color(0xFF000080),
                            ),)
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const SizedBox(height: 70.0,),
                      GestureDetector(
                        onTap: _signUp,
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: const LinearGradient(
                                colors:[
                                  Color(0xFF000080),
                                  Color(0xFF87CEEB),
                                ]
                            ),
                          ),
                          child: const Center(child: Text('SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),),
                        ),
                      ),

                      const SizedBox(height: 80,),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Already have an account",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            ),
                            Text("Sign in",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
}
