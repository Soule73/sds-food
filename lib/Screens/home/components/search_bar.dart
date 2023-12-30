import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          fillColor: Theme.of(context).primaryColor,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          prefixIcon: SvgPicture.asset('assets/icons/search.svg',
              fit: BoxFit.scaleDown),
          hintText: 'Trouver pour la nutrition'),
    );
  }
}
