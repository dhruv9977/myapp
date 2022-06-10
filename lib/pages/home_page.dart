import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login_page.dart';
import 'package:flutter_demo/pages/note_page.dart';
import 'package:flutter_demo/pages/verify_email_page.dart';
import 'package:flutter_demo/services/auth/auth_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthSevice.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthSevice.firebase().currentUser;
            if (user != null) {
              return const NotePage();
            } else {
              return const LoginPage();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
