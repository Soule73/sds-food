import 'package:get/get.dart';
import 'package:sds_food/Models/category_model.dart';
import 'package:sds_food/services/api_category.dart';

class CategorysController extends GetxController {
  @override
  void onInit() {
    getCategorysFromFirebase();
    super.onInit();
  }

  var isLoadingCategorys = false.obs;
  var selectedIndex = 0.obs;

  final ApiCategory apiCategory = ApiCategory();

  List<Category> categorysList = [
    Category(sId: "allitems", name: "Tous", icon: null)
  ];

  void setIsLoadingCategorys(bool newValue) {
    isLoadingCategorys.value = newValue;
  }

  void setSelectedIndex(int index) {
    selectedIndex = index as RxInt;
  }

  Future<void> getCategorysFromFirebase() async {
    try {
      setIsLoadingCategorys(true);
      List<Category> newCategorysList =
          await apiCategory.getCategorysFromFirebase();

      categorysList = [...categorysList, ...newCategorysList];

      setIsLoadingCategorys(false);
    } catch (e) {
      setIsLoadingCategorys(false);
    }
  }
}
