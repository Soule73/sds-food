import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ApiFavori {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<String> favoris = [];

  Future<List<String>> getFavorisByUserId(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('favoris')
              .where("userId", isEqualTo: userId)
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data();

        favoris.add(data['itemId']);
      }
      return favoris;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching Favoris: $error');
      }
      return [];
    }
  }

  Future<void> addOrDeleteFavori(
      String userId, String itemId, bool isRemove) async {
    if (isRemove) {
// Obtenir la requête
      Query query = firebaseFirestore
          .collection('favoris')
          .where("itemId", isEqualTo: itemId);

// Obtenir le QuerySnapshot
      QuerySnapshot querySnapshot = await query.get();

// Parcourir les documents et les supprimer
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      try {
        await firebaseFirestore
            .collection('favoris')
            .add({"itemId": itemId, "userId": userId});
      } catch (error) {
        if (kDebugMode) {
          print('Error fetching Favoris: $error');
        }
      }
    }
  }
}
