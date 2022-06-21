import 'package:flutter/material.dart';
import 'package:flutter_demo/constant/routes.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/pages/login_page.dart';
import 'package:flutter_demo/pages/catalog_page.dart';
import 'package:flutter_demo/pages/register_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(
    MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginPage(),
        registerRoute: (context) => const RegisterPage(),
        homeRoute: (context) => const HomePage(),
        catalogRoute: (context) => const CatalogPage(),
      },
    ),
  );
}
