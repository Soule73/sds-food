import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.tap,
  });

  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: GestureDetector(
        onTap: tap,
        child: Container(
          height: 35.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Get.context!.theme.primaryColor),
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.4),
          margin: const EdgeInsets.only(right: kDefaultPadding * 0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/filter.svg',
                // ignore: deprecated_member_use
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
