import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sds_food/controllers/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Déclarer une variable pour stocker l'instance de Firebase Storage
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Déclarer une variable pour stocker l'instance de Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Déclarer une variable pour stocker l'instance de Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Créer un widget ImagePicker
  Widget _imagePicker() {
    return Column(
      children: [
        // Créer des boutons pour choisir une image à partir de la galerie ou de la caméra
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: () async {
                // Utiliser la méthode pickImage du widget ImagePicker pour choisir une image à partir de la galerie
                XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                // Vérifier si l'utilisateur a choisi une image
                if (pickedFile != null) {
                  upload(File(pickedFile.path));
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                // Utiliser la méthode pickImage du widget ImagePicker pour choisir une image à partir de la caméra
                XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                // Vérifier si l'utilisateur a choisi une image
                if (pickedFile != null) {
                  // Mettre à jour l'état du widget avec l'image locale
                  upload(File(pickedFile.path));
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  void upload(File file) async {
    ProfileController profileController = Get.put(ProfileController());
    profileController.setisSetUserProfile(true);
    // Vérifier si l'utilisateur a choisi une image
    // Appeler la fonction uploadImage avec le chemin de l'image locale
    await uploadImage(file);
    // Appeler la fonction updateUser avec l'URL de l'image téléchargée
  }

  // Créer une fonction uploadImage qui prend en paramètre le chemin de l'image locale
  Future<void> uploadImage(File file) async {
    // Créer une référence de stockage avec le nom de l'image
    String uid = _auth.currentUser!.uid;

    try {
      Reference refExist =
          FirebaseStorage.instance.ref().child('profile_images/$uid');
// Utiliser la méthode delete pour supprimer le fichier de Firebase Storage
      refExist.delete();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    // Créer une référence de stockage avec le nom du fichier
    Reference ref = _storage.ref().child('profile_images/$uid');
    // Utiliser la méthode putFile de la référence pour télécharger l'image vers Firebase Storage
    UploadTask uploadTask = ref.putFile(file);
    // Attendre la fin du téléchargement et récupérer l'URL de l'image téléchargée
    String url = await (await uploadTask).ref.getDownloadURL();
    // Mettre à jour l'état du widget avec l'URL de l'image téléchargée
    await updateUser(url);
  }

  // Créer une fonction updateUser qui prend en paramètre l'URL de l'image téléchargée
  Future<void> updateUser(String imageUrl) async {
    // Récupérer l'identifiant de l'utilisateur connecté
    String uid = _auth.currentUser!.uid;
    // Utiliser la méthode update de l'instance de Firestore pour mettre à jour le document de l'utilisateur dans la collection users
    await _firestore.collection('users').doc(uid).update({
      'photoUrl': imageUrl,
    });

    ProfileController profileController = Get.put(ProfileController());

    profileController.setImageUrl("");

    profileController.getUser();
    Get.snackbar(
        'Succés', // Titre du snackbar
        'Votre photo de profil a été mise à jour avec succès !', // Message du snackbar
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.grey[100]!,
        boxShadows: [
          BoxShadow(
              offset: const Offset(4, 0),
              blurRadius: 16,
              color: Colors.grey[300]!)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _imagePicker(),
      // Afficher le widget ImagePicker
    );
  }
}
