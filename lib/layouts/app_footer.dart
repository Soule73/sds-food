import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0, // Fixé en bas
      left: 0,
      right: 0,
      child: Container(
        // color: Colors.blue, // Couleur de fond pour le rendre visible
        padding:
            const EdgeInsets.fromLTRB(0, 5, 0, 15), // Padding pour le texte
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Powered by',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, // Couleur du texte
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 5),
            const Text(
              'SDS',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.pink, // Couleur du texte
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
