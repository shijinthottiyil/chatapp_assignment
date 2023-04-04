import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/message_controller.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fireStore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageController>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Chat Screen'),
        ),
        body: StreamBuilder(
          stream: fireStore
              .collection('messages')
              .doc(auth.currentUser!.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var snap = snapshot.data!.data()!;
              return ListView.builder(
                itemCount: snapshot.data!.data()!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: snap['message'],
                  );
                },
              );
            }
          },
        ),
        bottomNavigationBar: Row(
          children: [
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'enter message',
              ),
            ),
            GestureDetector(
              onTap: () async {
                await value.addMessage(messageController.text.trim());
              },
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                child: Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }
}
