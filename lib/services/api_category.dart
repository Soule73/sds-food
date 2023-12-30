import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sds_food/Models/category_model.dart';

class ApiCategory {
  Future<List<Category>> getCategorysFromFirebase() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection('category').get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> categoryMaps =
          querySnapshot.docs;
      final List<Category> categorys =
          categoryMaps.map((e) => Category.fromJson(e.data(), e.id)).toList();

      return categorys;
    } catch (error) {
      // ignore: avoid_print
      print('Error fetching categorys: $error');

      return [];
    }
  }
}
