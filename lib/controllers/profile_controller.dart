import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  var imageUrl = "".obs;
  RxBool isSetUserProfile = false.obs;

  setImageUrl(String url) {
    imageUrl.value = url;
  }

  setisSetUserProfile(bool val) {
    isSetUserProfile.value = val;
  }

  Future<void> getUser() async {
    if (imageUrl.value == "") {
      setisSetUserProfile(true);

      // Déclarer une variable pour stocker l'instance de Firestore
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      // Déclarer une variable pour stocker l'instance de Firebase Auth
      final FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        final String uid = auth.currentUser!.uid;
        // Utiliser la méthode update de l'instance de Firestore pour mettre à jour le document de l'utilisateur dans la collection users
        DocumentSnapshot user =
            await firestore.collection('users').doc(uid).get();
        imageUrl.value = user["photoUrl"];
        setisSetUserProfile(false);
      }
    }
  }
}
