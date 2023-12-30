import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sds_food/Models/item_model.dart';
import 'package:sds_food/Screens/details/details.dart';
import 'package:get/get.dart';
import 'package:sds_food/controllers/favoris_controller.dart';
import 'package:sds_food/utils/get_image_color_dominant.dart';

import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  ItemCard({
    super.key,
    required this.item,
    required this.index,
  });

  final FavorisController favorisController = Get.put(FavorisController());
  // final Item? item;
  final int index;

  final PaletteColorUtil paletteColorUtil = PaletteColorUtil();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() => DetailsScreen(item: item));
        },
        child: FutureBuilder(
            future: paletteColorUtil
                .updatePaletteGenerator(NetworkImage(item.image!)),
            builder:
                (BuildContext context, AsyncSnapshot<List<Color?>> snapshot) {
              final List<Color?>? color = snapshot.data;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width > 700 ? 40 : 25),
                  color: color?[0],
                ),
                margin: EdgeInsets.only(
                    top: index.isOdd ? 10 : 0, bottom: index.isOdd ? 0 : 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: item.sId!,
                      child: Image(
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                          item.image!,
                        ),
                        errorBuilder: (BuildContext context, Object object,
                            StackTrace? stackTrace) {
                          return Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: FaIcon(
                                FontAwesomeIcons.burger,
                                size: 50,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 0.4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20, left: 20, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name!.capitalize!,
                                  style: TextStyle(color: color?[1]),
                                ),
                                Text(
                                  '${item.price} Mru',
                                  style: const TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Obx(() => IconButton(
                              icon: favorisController.favorisList
                                      .contains(item.sId!)
                                  ? const FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Colors.pink,
                                    )
                                  : SvgPicture.asset('assets/icons/heart.svg'),
                              onPressed: () async {
                                await favorisController
                                    .addOrDeleteFavori(item.sId!);
                              }))
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
