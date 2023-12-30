import 'package:get/get.dart';
import 'package:sds_food/Models/item_model.dart';
import 'package:sds_food/services/api_item.dart';

class ItemsController extends GetxController {
  @override
  void onInit() {
    getItemsFromFirebase();
    super.onInit();
  }

  var isLoadingItems = false.obs;
  final ApiItem apiItem = ApiItem();

  List<Item> itemsList = [];

  void setIsLoadingItems(bool newValue) {
    isLoadingItems.value = newValue;
  }

  Future<void> getItemsFromFirebase() async {
    try {
      setIsLoadingItems(true);
      itemsList = await apiItem.getItemsFromFirebase();

      setIsLoadingItems(false);
    } catch (e) {
      setIsLoadingItems(false);
    }
  }

  Future<void> getItemsByCategoryId(String categoryId) async {
    try {
      setIsLoadingItems(true);
      itemsList = await apiItem.getItemsByCategoryId(categoryId);

      setIsLoadingItems(false);
    } catch (e) {
      setIsLoadingItems(false);
    }
  }

  Future<void> searchItems(String text) async {
    String search = text.trim();
    try {
      setIsLoadingItems(true);
      if (search != "") {
        itemsList = await apiItem.searchItems(search);
      } else {
        itemsList = await apiItem.getItemsFromFirebase();
      }

      setIsLoadingItems(false);
    } catch (e) {
      setIsLoadingItems(false);
    }
  }
}
