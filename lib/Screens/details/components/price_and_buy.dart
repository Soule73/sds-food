import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sds_food/Models/item_model.dart';
import 'package:sds_food/controllers/checkout_controller.dart';

import 'buy_button.dart';

class PriceAndBuy extends StatelessWidget {
  PriceAndBuy({super.key, required this.item, required this.color});

  final CheckOutController checkOutController = Get.put(CheckOutController());

  final Item item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  'Prix',
                  style: TextStyle(fontSize: 18.0, color: color),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: item.price.toString(),
                        style: TextStyle(color: color, fontSize: 18)),
                    const TextSpan(
                        text: ' Mru',
                        style: TextStyle(color: Colors.pink, fontSize: 18)),
                  ]),
                )
              ],
            )),
        // const Spacer(),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: BuyButton(
                tap: () => checkOutController.addItemToCart(CartItem(
                    item: item, qty: checkOutController.qtyCounter.value)),
              ),
            )),
      ],
    );
  }
}
