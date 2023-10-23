// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:demo/pages/admin_page.dart';
import 'package:demo/pages/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    if (user.email == "demo@mail.com") {
      return const AdminPage();
    }
    return UserPage();
  }
}
