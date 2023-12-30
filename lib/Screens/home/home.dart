import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sds_food/Screens/home/components/categories.dart';
import 'package:sds_food/Screens/home/components/filter.dart';
import 'package:sds_food/Screens/home/components/item_card.dart';
import 'package:sds_food/components/scaffold_default.dart';
import 'package:sds_food/constants.dart';
import 'package:get/get.dart';
import 'package:sds_food/controllers/checkout_controller.dart';
import 'package:sds_food/controllers/items_controller.dart';
import 'package:sds_food/themes/theme_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ItemsController _listOfItemsController = Get.put(ItemsController());

  final TextEditingController textEditingController = TextEditingController();
  final themeController = Get.put(ThemeController());

  final CheckOutController checkOutController = Get.put(CheckOutController());

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
        title: 'Menu',
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trouvez la meilleure \npour votre santé',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: kDefaultPadding),
              SearchBar(
                  controller: textEditingController,
                  onChanged: (_) {
                    _listOfItemsController
                        .searchItems(textEditingController.text);
                  },
                  hintText: 'Rechercher pour la nutrition',
                  leading: IconButton(
                    icon: SvgPicture.asset('assets/icons/search.svg',
                        fit: BoxFit.scaleDown),
                    onPressed: () {},
                  )),
              Row(children: [
                FilterButton(
                  tap: () {},
                ),
                Expanded(child: Categories())
              ]),
              const SizedBox(height: kDefaultPadding),
              Text(
                'Populaire',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: kDefaultPadding),
              Obx(() => _listOfItemsController.isLoadingItems.value
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            "Chargement...",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                    )
                  : _listOfItemsController.itemsList.isEmpty
                      ? Center(
                          child: ElevatedButton(
                              onPressed: () =>
                                  _listOfItemsController.getItemsFromFirebase(),
                              child: const Text("Essayer")),
                        )
                      : ListItem(listOfItemsController: _listOfItemsController))
            ],
          ),
        ));
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required ItemsController listOfItemsController,
  }) : _listOfItemsController = listOfItemsController;

  final ItemsController _listOfItemsController;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.all(0),
      crossAxisCount: MediaQuery.of(context).size.width > 1024
          ? 6
          : MediaQuery.of(context).size.width > 600
              ? 3
              : 2,
      itemCount: _listOfItemsController.itemsList.length,
      crossAxisSpacing: 10,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      mainAxisSpacing: 0,
      itemBuilder: (context, index) {
        return ItemCard(
            item: _listOfItemsController.itemsList[index], index: index);
      },
    );
  }
}
