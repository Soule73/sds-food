import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar buildAppBar(BuildContext context,
    {String? title, required List<Widget> actions, Widget? leading}) {
  return AppBar(
    backgroundColor: Colors.pink,
    elevation: 0,
    title: Text(
      title ?? "",
      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
    ),
    centerTitle: true,
    leading: leading,
    actions: actions,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
