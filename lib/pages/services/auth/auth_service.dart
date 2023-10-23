import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  //instances of auth
  String role = "";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of Firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //sign user in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      //sign in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //add a new document for the user in users collection if it doesn't already exist
      if (email == "demo@mail.com") {
        role = 'Admin';
      } else {
        role = 'User';
      }
      _fireStore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email, 'role': role},
          SetOptions(merge: true));

      return userCredential;
    }
    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //create a new User
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password, name, role) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //after creating a user,create a new document for the user in the users collection
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'name': name,
        'role': role
      });
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
