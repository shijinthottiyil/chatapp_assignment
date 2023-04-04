import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/view/screen/chat_screen.dart';
import 'package:flutter_application_1/view/util/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('home'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'passsword',
                ),
                controller: passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await value.loginWithEmail(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                      ),
                    );
                  }
                },
                child:
                    value.isLoading ? Constants.loader : const Text('Sign Up'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
