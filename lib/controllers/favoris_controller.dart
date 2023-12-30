import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sds_food/components/alerte.dart';
import 'package:sds_food/services/api_favori.dart';

class FavorisController extends GetxController {
  @override
  void onInit() {
    getFavorisFromFirebase();
    super.onInit();
  }

  final ApiFavori apiFavori = ApiFavori();

  RxList<String> favorisList = RxList<String>();

  final User? user = FirebaseAuth.instance.currentUser;
  Future<void> getFavorisFromFirebase() async {
    if (user != null) {
      try {
        List<String> newFavorisList =
            await apiFavori.getFavorisByUserId(user!.uid);

        favorisList.value = newFavorisList;
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  Future<void> addOrDeleteFavori(String itemId) async {
    if (user != null) {
      if (favorisList.contains(itemId)) {
        favorisList.remove(itemId);
        await apiFavori.addOrDeleteFavori(user!.uid, itemId, true);
      } else {
        await apiFavori.addOrDeleteFavori(user!.uid, itemId, false);
        favorisList.add(itemId);
      }

      // await getFavorisFromFirebase();
    } else {
      AlertMessage().alertMessage("Info",
          "Veuilez vous connecté pour ajouté au favoris", "info", Get.back);
    }
  }
}
