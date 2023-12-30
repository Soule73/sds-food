import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sds_food/Models/item_model.dart';

import '../../../constants.dart';

class Ingredients extends StatelessWidget {
  const Ingredients({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ListView.builder(
          itemCount: item.ingrediants?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  // border: Border.all(color: Theme.of(context).primaryColor),
                  // color: Colors.pink[100]
                  color: Theme.of(context).cardColor),
              width: 50.0,
              margin: const EdgeInsets.only(right: kDefaultPadding),
              alignment: Alignment.center,
              child: SvgPicture.asset(item.ingrediants![index]),
            );
          }),
    );
  }
}
