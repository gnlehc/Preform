import 'package:get/get.dart';
import 'package:preform/user_auth/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Error in signing up");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Provider.of<UserProvider>(context, listen: false)
          .setUserEmail(credential.user?.email);

      Get.find<UserProvider>().setUserEmail(credential.user?.email);
      return credential.user;
      
    } catch (e) {
      print('Error signing in: $e');
    }
  }
}
