import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sds_food/Models/item_model.dart';
import 'package:sds_food/Screens/details/components/qty_counter.dart';
import 'package:sds_food/components/scaffold_default.dart';
import 'package:sds_food/constants.dart';
import 'package:sds_food/controllers/checkout_controller.dart';

import 'components/ingredients.dart';
import 'components/price_and_buy.dart';
import 'components/title.dart';
import 'components/vitamins.dart';
import 'package:get/get.dart';
// import 'package:palette_generator/palette_generator.dart';
import 'package:sds_food/utils/get_image_color_dominant.dart';

class DetailsScreen extends StatelessWidget {
  final Item item;

  DetailsScreen({super.key, required this.item});

  final PaletteColorUtil paletteColorUtil = PaletteColorUtil();
  final CheckOutController checkOutController = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ScaffoldDefault(
        leading: IconButton(
            icon: SvgPicture.asset('assets/icons/back.svg'),
            onPressed: () {
              Get.back();
            }),
        title: 'Detail',
        bottomNameFalse: true,
        body: FutureBuilder<List<Color?>>(
          future: paletteColorUtil
              .updatePaletteGenerator(NetworkImage(item.image!)), // async work
          builder:
              (BuildContext context, AsyncSnapshot<List<Color?>> snapshot) {
            final List<Color?> color = snapshot.data ??
                [
                  Theme.of(context).cardColor,
                  Theme.of(context).primaryColor,
                  Colors.pink
                ];

            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.2),
                  padding: EdgeInsets.only(top: size.height * 0.2),
                  height: size.height * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(kDefaultPadding * 5),
                        topRight: Radius.circular(kDefaultPadding * 5),
                      ),
                      color: color[0]),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                        kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleBar(
                          item: item,
                          color: color[2]!,
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Detail',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: color[2],
                                  fontWeight: FontWeight.w600),
                            ),
                            QtyCounter(color: color[2]!),
                          ],
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            item.description!,
                            style: TextStyle(
                              fontSize: 16,
                              color: color[1],
                            ),
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Vitamins(item: item),
                        const SizedBox(height: kDefaultPadding),
                        Text(
                          'Ingredients',
                          style: TextStyle(
                            fontSize: 18,
                            color: color[2],
                          ),
                        ),
                        const SizedBox(height: kDefaultPadding),
                        Ingredients(item: item),
                        const SizedBox(height: kDefaultPadding * 2),
                        PriceAndBuy(
                          item: item,
                          color: color[1]!,
                        )
                      ],
                    ),
                  ),
                ),
                Hero(
                  tag: item.sId!,
                  child: Image(
                    height: size.height * 0.4,
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                      item.image!,
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
