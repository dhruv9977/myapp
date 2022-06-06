import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login_page.dart';
import 'package:flutter_demo/pages/register_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(
    MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const LoginPage(),
    ),
  );
}
