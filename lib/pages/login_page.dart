import 'package:flutter/material.dart';
import 'package:flutter_demo/constant/routes.dart';
import 'package:flutter_demo/services/auth/auth_exceptions.dart';
import 'package:flutter_demo/services/auth/auth_services.dart';
import 'package:flutter_demo/utilities/show_error_dialog.dart';
import '../utilities/push_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
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
                  await AuthSevice.firebase().logIn(
                    email: email,
                    password: password,
                  );
                  // ignore: use_build_context_synchronously
                  toPushView(context, catalogRoute);
                } on UserNotFoundAuthException {
                  showErrorDialog(
                    context,
                    'User not Found',
                  );
                } on WrongPasswordAuthException {
                  showErrorDialog(
                    context,
                    'Wrong Password',
                  );
                } on GenericAuthException {
                  showErrorDialog(
                    context,
                    'Authentication error',
                  );
                }
              },
              style: TextButton.styleFrom(minimumSize: const Size(150, 40)),
              child: const Text('Login'),
            ),
            TextButton(
                onPressed: () {
                  toPushView(context, registerRoute);
                },
                child: const Text("Not registered yet? Register here!"))
          ],
        ),
      ),
    );
  }
}
