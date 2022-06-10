import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/constant/routes.dart';
import 'package:flutter_demo/firebase_options.dart';
import 'package:flutter_demo/utilities/push_view.dart';

import '../utilities/show_error_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextField(
                        controller: _email,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          labelText: 'Username',
                        )),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final email = _email.text;
                          final password = _password.text;
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          User? user = FirebaseAuth.instance.currentUser;
                          await user?.sendEmailVerification();
                          // ignore: use_build_context_synchronously
                          toPushView(context, homeRoute);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "weak-password") {
                            showErrorDialog(
                              context,
                              'Weak Password',
                            );
                          } else if (e.code == "email-already-in-use") {
                            showErrorDialog(
                              context,
                              'Email is already in use',
                            );
                          } else if (e.code == "invalid-email") {
                            showErrorDialog(
                              context,
                              'Invalid email address',
                            );
                          } else {
                            showErrorDialog(
                              context,
                              e.code,
                            );
                          }
                        } catch (e) {
                          showErrorDialog(
                            context,
                            e.toString(),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                          minimumSize: const Size(150, 40)),
                      child: const Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {
                        toPushView(context, loginRoute);
                      },
                      child: const Text("Already registered? Login here!"),
                    )
                  ],
                ),
              );
            default:
              return const CircularProgressIndicator(
                strokeWidth: 2,
              );
          }
        },
      ),
    );
  }
}
