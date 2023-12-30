import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sds_food/Models/item_model.dart';

class ApiItem {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<Item> litsItem(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> itemMaps) {
    final List<Item> items =
        itemMaps.map((e) => Item.fromJson(e.data(), e.id)).toList();

    return items;
  }

  Future<List<Item>> getItemsFromFirebase() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection('items').get();
      return litsItem(querySnapshot.docs);
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching Items: $error');
      }
      return [];
    }
  }

  Future<List<Item>> getItemsByCategoryId(String categoryId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('items')
              .where("categoryId", isEqualTo: categoryId)
              .get();
      return litsItem(querySnapshot.docs);
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching Items: $error');
      }
      return [];
    }
  }

  Future<List<Item>> searchItems(String text) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('items')
              .orderBy("name")
              .startAt([text]).endAt(['$text\uf8ff']).get();
      return litsItem(querySnapshot.docs);
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching Items: $error');
      }
      return [];
    }
  }
}
