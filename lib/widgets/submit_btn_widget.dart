import 'package:flutter/material.dart';

class SubmitBtnWidget extends StatelessWidget {
  final String title;
  final Function onPress;
  final Widget? loading;
  const SubmitBtnWidget(
      {super.key, required this.title, required this.onPress, this.loading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPress();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.pink,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(double.infinity, 50),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading ?? Container(),
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
          ],
        ));
  }
}
