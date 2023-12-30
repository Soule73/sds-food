import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sds_food/Models/item_model.dart';
import 'package:sds_food/controllers/favoris_controller.dart';

import '../../../constants.dart';

class TitleBar extends StatelessWidget {
  TitleBar({
    super.key,
    required this.item,
    required this.color,
  });

  final FavorisController favorisController = Get.put(FavorisController());

  final Item item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name!.capitalize!,
                style: TextStyle(
                  fontSize: 24,
                  color: color,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: kDefaultPadding * 0.8,
                  ),
                  const SizedBox(width: kDefaultPadding * 0.5),
                  Text(
                    '${item.rating.toString()} (${item.ratingCount.toString()})',
                    style: const TextStyle(color: Colors.pink),
                  )
                ],
              )
            ],
          ),
        ),
        Obx(() => IconButton(
            icon: favorisController.favorisList.contains(item.sId!)
                ? const FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.pink,
                  )
                : SvgPicture.asset('assets/icons/heart.svg'),
            onPressed: () async {
              await favorisController.addOrDeleteFavori(item.sId!);
            }))
      ],
    );
  }
}
