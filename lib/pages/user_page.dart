import 'package:demo/utils/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final user = FirebaseAuth.instance.currentUser!;
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "iSocial Portal",
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Icon(
                Icons.person,
                size: 59,
                color: Colors.green,
              ),
              
              const SizedBox(
                height: 10,
              ),
              MyButton(onTap: () {}, text: 'View Posts'),
              const SizedBox(
                height: 10,
              ),
              MyButton(onTap: () {}, text: 'Comment on Posts')
            ],
          ),
        ));
  }
}
