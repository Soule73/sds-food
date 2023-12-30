import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFileController extends GetxController {
  // Déclarer une variable pour stocker l'URL de l'image téléchargée
  RxString imageUrl = "".obs;

  UploadFileController uploadFileController = Get.put(UploadFileController());
  // Déclarer une variable pour stocker l'image locale
  File? _image;

  // Déclarer une variable pour stocker l'URL de l'image téléchargée
  // String? _imageUrl;

  // Déclarer une variable pour stocker l'instance de Firebase Storage
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Créer une fonction uploadImage qui prend en paramètre le chemin de l'image locale
  Future<void> uploadImage(String imagePath) async {
    // Créer une référence de stockage avec le nom de l'image
    Reference ref =
        _storage.ref().child('profile_images/${_image!.path.split('/').last}');
    // Utiliser la méthode putFile de la référence pour télécharger l'image vers Firebase Storage
    UploadTask uploadTask = ref.putFile(_image!);
    // Attendre la fin du téléchargement et récupérer l'URL de l'image téléchargée
    String url = await (await uploadTask).ref.getDownloadURL();
    // Mettre à jour l'état du widget avec l'URL de l'image téléchargée
    uploadFileController.setSImageUrl(url);
  }

  void setSImageUrl(String url) {
    imageUrl.value = url;
  }
}

class UploadFile {}
