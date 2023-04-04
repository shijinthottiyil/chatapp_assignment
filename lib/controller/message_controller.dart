import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageController with ChangeNotifier {
  final auth = FirebaseAuth.instance;

  Future<void> addMessage(String message) async {
    try {
      await FirebaseFirestore.instance
          .collection('messages')
          .doc(auth.currentUser!.uid)
          .set({
        'message': message,
        'name': auth.currentUser!.displayName,
        'uid': auth.currentUser!.uid,
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
