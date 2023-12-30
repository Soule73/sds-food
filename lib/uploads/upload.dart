import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  // Déclarer une variable pour stocker l'image locale
  File? _image;
  String progressState = "";
  bool uploading = false;

  setProgress(String val) {
    setState(() {
      progressState = val;
    });
  }

  setUploading(bool val) {
    setState(() {
      uploading = val;
    });
  }

  // Déclarer une variable pour stocker l'URL de l'image téléchargée

  // Déclarer une variable pour stocker l'instance de Firebase Storage
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Créer un widget ImagePicker
  Widget _imagePicker() {
    return Column(
      children: [
        // Afficher l'image locale si elle existe, sinon afficher un placeholder
        _image != null
            ? Image.file(_image!, height: 200, width: 200)
            : const Text("data"),
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
                  // Mettre à jour l'état du widget avec l'image locale
                  setState(() {
                    _image = File(pickedFile.path);
                  });
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
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  // Créer une fonction uploadImage qui prend en paramètre le chemin de l'image locale
  Future<void> uploadImage(String imagePath) async {
    setUploading(true);
    // Créer une référence de stockage avec le nom de l'image
    Reference ref =
        _storage.ref().child('profile_images/${_image!.path.split('/').last}');
    // Utiliser la méthode putFile de la référence pour télécharger l'image vers Firebase Storage
    UploadTask uploadTask = ref.putFile(_image!);

    // Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          var progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          setProgress("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          setProgress("Upload is paused.");
          break;
        case TaskState.canceled:
          setProgress("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          {
            // Handle successful uploads on complete
            setProgress("Complete");
            setUploading(false);
            setState(() {
              _image = null;
            });
            break;
          }
        
      }
    });
    // Attendre la fin du téléchargement et récupérer l'URL de l'image téléchargée
    String url = await (await uploadTask).ref.getDownloadURL();
    // Mettre à jour l'état du widget avec l'URL de l'image téléchargée
    if (kDebugMode) {
      print(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Afficher le widget ImagePicker
          _imagePicker(),

          // Créer un bouton pour valider la photo de profil
          ElevatedButton(
            child: const Text('Valider'),
            onPressed: () async {
              // Vérifier si l'utilisateur a choisi une image
              if (_image != null) {
                // Appeler la fonction uploadImage avec le chemin de l'image locale
                await uploadImage(_image!.path);
              } else {
                // Afficher un message d'erreur à l'utilisateur
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Veuillez choisir une image !'),
                  ),
                );
              }
            },
          ),
          if (uploading) Text(progressState)
        ],
      ),
    );
  }
}
