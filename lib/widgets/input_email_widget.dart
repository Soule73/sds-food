import 'package:flutter/material.dart';

class InputEmailWidget extends StatefulWidget {
  final String placeHolder;
  // final Function onChanged;
  final TextEditingController controller;
  const InputEmailWidget(
      {super.key,
      required this.placeHolder,
      // required this.onChanged,
      required this.controller});

  @override
  State<InputEmailWidget> createState() => _InputEmailWidgetState();
}

class _InputEmailWidgetState extends State<InputEmailWidget> {
  // final TextEditingController _emailController = TextEditingController();

  // @override
  // void dispose() {
  //   _emailController.dispose(); // N'oubliez pas de disposer le contrôleur
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: widget.placeHolder,
        // labelText: 'Email', // Ajout d'un label pour l'email
        // suffixIcon: IconButton(
        //   icon: const Icon(Icons.clear),
        //   onPressed: () {
        //     _emailController.clear(); // Effacer le contenu du champ de texte
        //   },
        // ),
      ),

      // onChanged: widget.onValueChange(),
      // onChanged: (value) {
      //   // Vous pouvez accéder à la valeur actuelle avec _emailController.text
      //   // ignore: avoid_print
      //   widget.onChanged(value);
      //   // print('L\'adresse email actuelle est : ${_emailController.text}');
      // },
      validator: (value) {
        // Ajout d'une validation pour l'adresse email
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer une adresse email';
        }
        if (!value.contains('@')) {
          return 'Veuillez entrer une adresse email valide';
        }
        return null; // Si tout est correct, retourner null
      },
    );
  }
}
