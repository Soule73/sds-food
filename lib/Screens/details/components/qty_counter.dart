import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sds_food/controllers/checkout_controller.dart';

import '../../../constants.dart';

class QtyCounter extends StatelessWidget {
  final Color? color;
  QtyCounter({
    super.key,
    this.color,
  });

  final CheckOutController checkOutController = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        QtyButton(
          tap: () => checkOutController.deIncrementQtyCounter(),
          icon: FontAwesomeIcons.minus,
        ),
        const SizedBox(width: 10),
        Obx(() => Text(
              checkOutController.qtyCounter.value.toString(),
              style: TextStyle(
                  fontSize: 22, color: color ?? Theme.of(context).primaryColor),
            )),
        const SizedBox(width: 10),
        QtyButton(
          tap: () => checkOutController.incrementQtyCounter(),
          icon: FontAwesomeIcons.plus,
        )
      ],
    );
  }
}

class QtyButton extends StatelessWidget {
  const QtyButton({
    super.key,
    required this.tap,
    required this.icon,
  });

  final GestureTapCallback tap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        width: 30.0,
        height: 30.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding * 0.5),
            color: Theme.of(context).cardColor),
        child: FaIcon(
          icon,
          color: Colors.pink,
          size: 15,
        ),
        // style: const TextStyle(color: Colors.pink, fontSize: 22),
      ),
    );
  }
}
