import 'package:flutter/material.dart';
import 'package:flutter_demo/constant/routes.dart';
import 'package:flutter_demo/services/auth/auth_services.dart';
import 'package:flutter_demo/utilities/push_view.dart';

enum MenuAction { logout }

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) {
              switch (value) {
                case MenuAction.logout:
                  logOut(context);
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text("Log Out"),
                )
              ];
            },
          )
        ],
      ),
    );
  }

  Future logOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await AuthSevice.firebase().logOut();
                // ignore: use_build_context_synchronously
                toPushView(context, loginRoute);
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}
