import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sds_food/Models/category_model.dart';
import 'package:sds_food/controllers/categorys_controller.dart';
import 'package:get/get.dart';
import 'package:sds_food/controllers/items_controller.dart';

import '../../../constants.dart';

class Categories extends StatelessWidget {
  Categories({
    super.key,
  });

  final CategorysController _listCategorysController =
      Get.put(CategorysController());

  final ItemsController itemsController = Get.put(ItemsController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: SizedBox(
          height: 35,
          child: Obx(
            () => _listCategorysController.isLoadingCategorys.value
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Chargement..",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _listCategorysController.categorysList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(() => CategoryCard(
                            onTap: () {
                              _listCategorysController.selectedIndex(index);
                              if (index != 0) {
                                itemsController.getItemsByCategoryId(
                                    _listCategorysController
                                        .categorysList[index].sId!);
                              } else {
                                itemsController.getItemsFromFirebase();
                              }
                            },
                            isSelected:
                                _listCategorysController.selectedIndex.value ==
                                    index,
                            category:
                                _listCategorysController.categorysList[index],
                          ));
                    }),
          )),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final Category category;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color:
                  isSelected ? Colors.pink : Get.context!.theme.primaryColor),
          color: Theme.of(context).cardColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.8),
        margin: const EdgeInsets.only(right: kDefaultPadding * 0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            category.icon != null
                ? SvgPicture.asset(
                    category.icon!,
                    // ignore: deprecated_member_use
                    color: isSelected
                        ? Colors.pink
                        : Theme.of(context).primaryColor,
                  )
                : Container(),
            const SizedBox(width: 5),
            Text(
              category.name!,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink)
                  : const TextStyle(
                      // color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
