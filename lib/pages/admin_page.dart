import 'package:demo/pages/services/database/product_screen.dart';
import 'package:demo/utils/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final user = FirebaseAuth.instance.currentUser!;
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('iSocial Admin Portal'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(Icons.logout))
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
                  Icons.settings,
                  size: 59,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyButton(onTap: () {}, text: 'View Posts'),
                const SizedBox(
                  height: 10,
                ),
                MyButton(onTap: () {}, text: 'Comment on Posts'),
                const SizedBox(
                  height: 10,
                ),
                MyButton(onTap: () {}, text: 'Delete Posts'),
                const SizedBox(
                  height: 10,
                ),
                MyButton(onTap: () {}, text: 'Ban Users'),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductListScreen()),
                      );
                    },
                    text: 'View Products'),
              ],
            ),
          )),
    );
  }
}
