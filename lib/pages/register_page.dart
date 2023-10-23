// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:demo/pages/services/auth/auth_service.dart';
import 'package:demo/utils/button.dart';
import 'package:demo/utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();
  final nameController = TextEditingController();
  
  // signup method
  void signUserUp() async {
    String email = emailTextController.text;
    String password = passwordTextController.text;
    String name = nameController.text;
    String role = '';
    if (email == "demo@mail.com") {
      role = "admin";
    } else {
      role = "user";
    }

    //show progress dialog/circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //check if passwords match
    if (passwordTextController.text != confirmpasswordTextController.text) {
      Fluttertoast.showToast(
          msg: "Passwords do not Match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    } else {
      //try sign up
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.signUpWithEmailandPassword(
            email, password, name, role);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }
      //pop the loading circle
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                //logo
                Icon(
                  Icons.person,
                  size: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                //welcome back text
                Text(
                  "Welcome Let Us Create an Account for you",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                MyTextField(
                    hintText: "Name",
                    obscureText: false,
                    controller: nameController),
                SizedBox(
                  height: 10,
                ),
                //username textfield
                MyTextField(
                    hintText: "Email",
                    obscureText: false,
                    controller: emailTextController),
                SizedBox(
                  height: 10,
                ),
                //password textfield
                MyTextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordTextController),

                SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: "Confirm Password",
                    obscureText: true,
                    controller: confirmpasswordTextController),
                // forgot password textbutton
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 25,
                ),
                // signin button
                MyButton(text: "Sign Up", onTap: signUserUp),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 15,
                ),
                // not a member register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
