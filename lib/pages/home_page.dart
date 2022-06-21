import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/login_page.dart';
import 'package:flutter_demo/pages/catalog_page.dart';
import 'package:flutter_demo/services/auth/auth_services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const appId = "9880a4fb-eb5f-4cc0-a2e4-61f22cac38a3";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthSevice.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthSevice.firebase().currentUser;
            if (user != null) {
              return const CatalogPage();
            } else {
              return const LoginPage();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(appId);
    // OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType);
  }
}
