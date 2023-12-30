import 'package:flutter/material.dart';
import 'package:sds_food/Models/item_model.dart';

import '../../../constants.dart';

class Vitamins extends StatelessWidget {
  const Vitamins({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.0,
      child: ListView.builder(
          itemCount: item.vitamins?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                  color: Theme.of(context).cardColor),
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              margin: const EdgeInsets.only(right: kDefaultPadding),
              alignment: Alignment.center,
              child: Text(item.vitamins![index]),
            );
          }),
    );
  }
}
