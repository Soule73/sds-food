import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OtherLoginIcon extends StatelessWidget {
  final IconData faIcon;
  final MaterialColor bgColor;

  const OtherLoginIcon(
      {super.key, required this.faIcon, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: IconButton(
            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
            icon: FaIcon(
              faIcon,
              size: 25,
              color: Colors.grey[100],
            ),
            onPressed: () {}),
      ),
    );
  }
}
