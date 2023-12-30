import 'package:flutter/material.dart';

class InputPasswordWidget extends StatefulWidget {
  final String placeHolder;
  // final Function onChange;
  final TextEditingController controller;
  const InputPasswordWidget(
      {super.key,
      required this.placeHolder,
      // required this.onChange,
      required this.controller});

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  bool _isObscure = true;

  setObscurre() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: widget.placeHolder,
        // labelText: 'Password',
        suffix: IconButton(
          padding: const EdgeInsets.all(0),
          iconSize: 20.0,
          icon: _isObscure
              ? const Icon(
                  Icons.visibility_off,
                  color: Colors.grey,
                )
              : const Icon(
                  Icons.visibility,
                  color: Colors.black,
                ),
          onPressed: setObscurre,
        ),
      ),
      // onChanged: (value) => widget.onChange(value),
    );
  }
}
