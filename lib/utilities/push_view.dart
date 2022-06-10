import 'package:flutter/cupertino.dart';

Future toPushView(BuildContext context, String routeName) {
  return Navigator.of(context).pushNamedAndRemoveUntil(
    routeName,
    (route) => false,
  );
}
