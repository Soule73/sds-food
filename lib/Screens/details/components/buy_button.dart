import 'package:flutter/material.dart';

import '../../../constants.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({
    super.key,
    required this.tap,
  });

  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding * 2),
            color: Theme.of(context).cardColor),
        height: 50.0,
        alignment: Alignment.center,
        child: Text(
          'Ajouter au panier',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
